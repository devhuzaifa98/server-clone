import prisma from "../clients/prisma";
import { Request, Response } from "express";
import stripe from "../clients/stripe";
import AppError from "../utilities/AppError";
import { getS3ObjectURL } from "../clients/s3";
import { creditItems } from "./webhooks.controller";
import { PaymentType } from "@prisma/client";
import { v4 as uuid } from "uuid";

export const listCoins = async (req: Request, res: Response) => {
  const coins = await prisma.product.findMany({
    where: {
      active: true,
      type: "COIN",
    },
  });
  return res.send({
    coins,
  });
};

export const getPurchasableCoins = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const findCoins = await prisma.product.findMany({
    where: {
      active: true,
      OR: [
        { inventory: { gt: 0 } },
        { inventory: { equals: -100 } }, //-100 means unlimited
      ],
      price: { gt: 199 },
      type: {
        in: ["COIN", "FOUNDERS_TOKEN", "MONTHLY_SUBSCRIPTION"],
      },
    },
    select: {
      id: true,
      appStoreProductId: true,
      playStoreProductId: true,
      inventory: true,
      price: true,
      discount: true,
      type: true,
      title: true,
      description: true,
      images: {
        select: {
          key: true,
        },
      },
      coin: {
        select: {
          quantity: true,
          premiumDays: true,
        },
      },
      subscriptions: {
        where: {
          userId,
          nextPayment: {
            gt: new Date(),
          },
        },
        select: {
          expires: true,
          nextPayment: true,
        },
      },
    },
  });

  return res.send({
    coins: findCoins.map((product) => {
      return {
        id: product.id,
        appStoreProductId: product.appStoreProductId,
        playStoreProductId: product.playStoreProductId,
        inventory: product.inventory,
        image: getS3ObjectURL(product.images[0].key) ?? null,
        title: product.title,
        description: product.description,
        type: product.type,
        price: product.price,
        discount: product.discount,
        coin: {
          quantity: product.coin?.quantity,
          premiumDays: product.coin?.premiumDays,
        },
        subscriptions: product.subscriptions.map((subscription) => {
          return {
            expires: subscription.expires,
            nextPayment: subscription.nextPayment,
          };
        }),
      };
    }),
  });
};

export const listPremium = async (req: Request, res: Response) => {
  const coins = await prisma.product.findMany({
    orderBy: {
      price: "asc",
    },
    where: {
      OR: [
        { active: true, type: "MONTHLY_SUBSCRIPTION" },
        { active: true, type: "FOUNDERS_TOKEN" },
      ],
    },
  });
  return res.send({
    coins,
  });
};

export const checkPurchase = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { productId } = req.params;
  //payment type is STRIPE/GOOGLE/APPLE
  //receivedPrice is the price sent from the front end, it is used to verify the price
  const { type: typeDeconflict, receivedPrice } = req.body;
  //Convert type to PaymentType, naming it typeDeconflict to avoid conflict with type keyword
  //Then reassign it to paymentType with the correct type, this also prevents invalid types
  const paymentType: PaymentType =
    PaymentType[typeDeconflict as keyof typeof PaymentType];

  const product = await prisma.product.findUnique({
    where: {
      id: +productId,
      active: true,
    },
    select: {
      id: true,
      inventory: true,
      price: true,
      discount: true,
      type: true,
      spaceId: true,
    },
  });

  //Check if product exists and is in stock
  if (!product || (product.inventory !== -100 && product.inventory <= 0))
    throw new AppError("This product cannot be purchased at this time.");

  //Stop user from purchasing a subscription if they already have an active subscription to that space
  if (product.type === "MONTHLY_SUBSCRIPTION") {
    //Find all products of type MONTHLY_SUBSCRIPTION for the space
    const products = await prisma.product.findMany({
      where: {
        type: "MONTHLY_SUBSCRIPTION",
        spaceId: product.spaceId,
      },
      select: {
        id: true,
      },
    });
    //Find if user has an active subscription to any of the products
    const subscription = await prisma.subscription.findFirst({
      where: {
        userId,
        productId: {
          in: products.map((product) => product.id),
        },
        expires: {
          gt: new Date(),
        },
        nextPayment: {
          not: null,
        },
      },
      select: {
        id: true,
      },
    });
    if (subscription)
      throw new AppError(
        "You already have an active subscription to this space. Cancel it to purchase a new one.",
      );
  }

  let payment: { id: string; client_secret: string | null; price: number };
  if (paymentType === "STRIPE") {
    //Apply 20% discount on coins if user has premium
    const factiiiPremium = await prisma.space.findUniqueOrThrow({
      where: {
        slug: "premium",
      },
      select: {
        id: true,
      },
    });
    const spaceMember = await prisma.spaceMember.findUnique({
      where: {
        userId_spaceId: {
          userId,
          spaceId: factiiiPremium.id,
        },
        premiumAccessExpires: {
          gt: new Date(),
        },
      },
      select: {
        premiumAccessExpires: true,
      },
    });
    //20% discount for premium members on coins
    //Add the product discount to the discountMultiplier
    const discountMultiplier =
      (product.type === "COIN" && spaceMember ? 0.8 : 1) -
      product.discount / 100;
    //Ensure discounts do not go above 50%
    //TODO read maxDicsount from siteSettings
    if (discountMultiplier < 0.5) {
      throw new AppError("Error processing payment. Please try again later.");
      //TODO send email/push to admin
    }

    //Set price to be paid and make sure it matches the receivedPrice that the customer was given
    const price = Math.floor(discountMultiplier * product.price);
    if (price !== receivedPrice) {
      throw new AppError("Error processing payment. Please try again later.");
      //TODO send a push notification to admin if price does not match, this is a serious issue
    }

    //Check if user is already a stripe customer
    //If not, create a new stripeCustomerId
    const user = await prisma.user.findUniqueOrThrow({
      where: {
        id: userId,
      },
      select: {
        stripeCustomerId: true,
      },
    });
    let customerId;
    if (user.stripeCustomerId) {
      customerId = user.stripeCustomerId;
    } else {
      // Create a new stripeCustomerId
      const createdCustomer = await stripe.customers.create({
        description: userId.toString(),
      });
      customerId = createdCustomer.id;
      await prisma.user.update({
        where: {
          id: userId,
        },
        data: {
          stripeCustomerId: customerId,
        },
      });
    }

    //Everything is good, create a paymentIntent and an order
    const stripePaymentIntent = await stripe.paymentIntents.create({
      amount: price,
      currency: "usd",
      customer: customerId,
      automatic_payment_methods: {
        enabled: true,
      },
      ...(product.type === "MONTHLY_SUBSCRIPTION"
        ? { setup_future_usage: "off_session" } // Indicate future usage for subscriptions
        : {}),
    });
    payment = {
      id: stripePaymentIntent.id,
      client_secret: stripePaymentIntent.client_secret,
      price,
    };
  } else {
    //Apple/Google IAP payment
    //Make a secret and save it as the paymentIntent and client_secret
    //The creditPurchase function will use this secret to verify the purchase
    const secret = "SECRET" + uuid();
    payment = {
      id: secret,
      client_secret: secret,
      price: 0, //set to 0 for now, the price will be verified in the creditPurchase function
    };
  }

  const order = await prisma.order.create({
    data: {
      userId,
      total: payment.price,
      items: {
        create: {
          price: payment.price,
          discount: product.price - payment.price,
          productId: product.id,
          quantity: 1,
        },
      },
      payments: {
        create: {
          paymentIntent: payment.id,
          amount: payment.price,
          userId,
          type: paymentType,
        },
      },
    },
    select: {
      id: true,
    },
  });

  // Decrement inventory
  //-100 means unlimitied quantity so do not decrement
  if (product.inventory !== -100) {
    await prisma.product.update({
      where: {
        id: product.id,
      },
      data: {
        inventory: {
          decrement: 1,
        },
      },
    });
  }

  // Set a timer to delete the order if payment is not completed in 10 minutes
  setTimeout(
    async () => {
      const existingOrder = await prisma.order.findUnique({
        where: {
          id: order.id,
        },
        select: {
          payments: {
            select: {
              completed: true,
            },
          },
        },
      });

      if (
        existingOrder &&
        existingOrder.payments.every((payment) => payment.completed === null)
      ) {
        // Delete the order and increment inventory
        //TODO add socket to alert user of failed payment
        prisma.order.delete({ where: { id: order.id } });
        //-100 means unlimitied quantity
        if (product.inventory !== -100) {
          await prisma.product.update({
            where: {
              id: product.id,
            },
            data: {
              inventory: {
                increment: 1,
              },
            },
          });
        }
      }
    },
    10 * 60 * 1000,
  );

  return res.send({
    secret: payment.client_secret,
  });
};

export const creditPurchase = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const {
    orderId,
    transactionDate,
    receivedPrice,
    type: typeDeconflict,
    secret,
  } = req.body;
  //Convert type to PaymentType, naming it typeDeconflict to avoid conflict with type keyword
  //Then reassign it to paymentType with the correct type
  const paymentType: PaymentType =
    PaymentType[typeDeconflict as keyof typeof PaymentType];

  //Convert string to number in cents
  const formatIAPPrice = (receivedPrice: string) => {
    //For IAP, the price is sent as a string in the currency's format
    //TODO validate price with apple/google
    if (
      receivedPrice.charAt(0) === "$" &&
      receivedPrice.split(".")[1]?.length === 2
    ) {
      //Detected as USD, strip $ and convert to cents
      return parseFloat(receivedPrice.substring(1)) * 100;
    } //TODO add other currencies
    return Number(receivedPrice);
  };

  const total = formatIAPPrice(receivedPrice);

  //Find the payment with the secret
  //Update the payment to the orderId and completed
  const payment = await prisma.payment.update({
    where: {
      paymentIntent_type: {
        paymentIntent: secret,
        type: paymentType,
      },
      userId,
    },
    data: {
      paymentIntent: orderId,
      completed: new Date(transactionDate),
      amount: total,
      order: {
        update: {
          total,
        },
      },
    },
    select: {
      id: true,
      completed: true,
      paymentIntent: true,
      paymentMethod: true,
      type: true,
      user: {
        select: {
          id: true,
          stripeCustomerId: true,
        },
      },
      order: {
        select: {
          total: true,
          user: {
            select: {
              id: true,
              stripeCustomerId: true,
            },
          },
          items: {
            select: {
              quantity: true,
              price: true,
              product: {
                select: {
                  id: true,
                  title: true,
                  stripeProductId: true,
                  type: true,
                  space: {
                    select: {
                      id: true,
                    },
                  },
                  coin: {
                    select: {
                      premiumDays: true,
                      quantity: true,
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  });
  if (!payment) {
    throw new AppError("Payment failed.");
    //TODO alert admin if payment is not found
  }

  creditItems(payment, new Date());

  return res.send({
    success: true,
  });
};

//TODO test this
export const listPurchases = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const orders = await prisma.order.findMany({
    where: {
      userId,
    },
    select: {
      createdAt: true,
      total: true,
      payments: {
        select: {
          completed: true,
          refunded: true,
        },
      },
      items: {
        select: {
          product: {
            select: {
              title: true,
              images: {
                select: {
                  key: true,
                },
              },
              price: true,
              createdAt: true,
              coin: {
                select: {
                  quantity: true,
                },
              },
            },
          },
        },
      },
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  const subscriptions = await prisma.subscription.findMany({
    where: {
      userId,
    },
    select: {
      nextPayment: true,
      subscriptionId: true,
      type: true,
      product: {
        select: {
          price: true,
        },
      },
      spaceMember: {
        select: {
          space: {
            select: {
              name: true,
              slug: true,
            },
          },
        },
      },
    },
  });

  return res.send({
    orders: orders.map((order) => ({
      ...order,
      items: order.items.map((item) => ({
        ...item,
        product: {
          ...item.product,
          image: getS3ObjectURL(item.product.images[0]?.key) ?? null,
        },
      })),
    })),
    subscriptions: subscriptions.map((subscription) => {
      return {
        subscriptionId: subscription.subscriptionId,
        nextPayment: subscription.nextPayment,
        type: subscription.type,
        price: subscription.product.price,
        space: subscription.spaceMember?.space,
      };
    }),
  });
};

export const coinRewards = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const rewards = await prisma.coinRewardItem.findMany({
    where: {
      OR: [
        {
          expiresAt: null,
        },
        {
          expiresAt: {
            gt: new Date(),
          },
        },
      ],
    },
  });

  const data: any[] = await Promise.all(
    rewards.map(async (reward) => {
      const isCompleted = await prisma.userCoinReward.count({
        where: {
          rewardId: reward.id,
          userId,
        },
      });

      return {
        ...reward,
        completed: isCompleted > 0,
      };
    }),
  );

  return res.send(data.sort((a: any, b: any) => a.completed - b.completed));
};

//Only for stripe
export const createDonation = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { amount, email } = req.body;

  if (Number(amount) <= 199)
    throw new AppError("Donation amount cannot be less than $1.99");

  const paymentIntent = await stripe.paymentIntents.create({
    amount,
    currency: "usd",
    automatic_payment_methods: {
      enabled: true,
    },
  });

  const factiiiSpace = await prisma.space.findUnique({
    where: {
      slug: "factiii",
    },
    select: {
      id: true,
    },
  });

  if (!factiiiSpace)
    throw new AppError("Error processing donation. Please try again later.");

  const donationProduct = await prisma.product.findFirst({
    where: {
      spaceId: factiiiSpace.id,
      stripeProductId: "donation",
      active: true,
    },
    select: {
      id: true,
    },
  });

  if (!donationProduct) throw new AppError("Product not found");

  const user = await prisma.user.upsert({
    where: {
      ...(userId !== 0 ? { id: userId } : { email }),
    },
    update: {},
    create: {
      email,
      username: email,
      password: "",
      types: ["PRIVATE"],
    },
    select: {
      id: true,
    },
  });

  //Add Order to User
  const order = await prisma.order.create({
    data: {
      userId: user.id,
      total: amount,
      items: {
        create: {
          price: amount,
          discount: 0,
          productId: donationProduct.id,
        },
      },
      payments: {
        create: {
          amount,
          paymentIntent: paymentIntent.id,
          type: "STRIPE",
          userId: user.id,
        },
      },
    },
    select: {
      id: true,
    },
  });

  // Set a timer to delete the order if not completed in 10 minutes
  setTimeout(
    async () => {
      const existingOrder = await prisma.order.findUnique({
        where: {
          id: order.id,
        },
        select: {
          payments: {
            select: {
              completed: true,
            },
          },
        },
      });

      if (
        existingOrder &&
        existingOrder.payments.every((payment) => payment.completed === null)
      ) {
        // Delete the order and increment inventory
        //TODO add socket to alert user of failed payment
        prisma.order.delete({ where: { id: order.id } });
      }
    },
    10 * 60 * 1000,
  );

  return res.send({
    success: true,
    secret: paymentIntent.client_secret,
  });
};

export const listDonations = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;

  const user = await prisma.user.findFirst({
    where: {
      id: userId,
    },
    select: {
      id: true,
      email: true,
    },
  });

  if (!user) throw new AppError("Invalid request.");

  const list = await prisma.order.findMany({
    where: {
      items: {
        every: {
          product: {
            // id: 'donation',
            stripeProductId: "donation",
          },
        },
      },
      userId,
    },
    select: {
      createdAt: true,
      items: {
        select: {
          price: true,
        },
      },
      payments: {
        select: {
          completed: true,
          refunded: true,
        },
      },
    },
  });

  return res.send({
    donations: list,
  });
};

export const cancelSubscription = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { subscriptionId } = req.params;

  const subCheck = await prisma.subscription.findUnique({
    where: {
      subscriptionId_type: {
        subscriptionId,
        type: "STRIPE",
      },
      userId,
    },
    select: {
      subscriptionId: true,
    },
  });

  if (!subCheck) throw new AppError("No such subscription found");

  await stripe.subscriptions.cancel(subCheck.subscriptionId);

  await prisma.subscription.update({
    where: {
      subscriptionId_type: {
        subscriptionId: subCheck.subscriptionId,
        type: "STRIPE",
      },
    },
    data: {
      nextPayment: null,
    },
  });

  return res.send({
    cancelled: true,
  });
};
