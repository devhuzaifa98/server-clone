import { Request, Response } from "express";
import stripe from "../clients/stripe";
import prisma from "../clients/prisma";
import AppError from "../utilities/AppError";
import nextMonth from "../helpers/nextMonth";
import log from "../helpers/log";
import { getIoInstance } from "../clients/socket";
import { ProductType } from "@prisma/client";
import { PaymentType } from "@prisma/client";

export const stripeHook = async (req: Request, res: Response) => {
  //TODO make the verify into function called stripeVerify toi sync stripeCoins with stripePaidCommunities
  const endpointSecret = process.env.STRIPE_COINS_WEBHOOK_SECRET as string;
  let event = req.body;

  if (endpointSecret) {
    // Get the signature sent by Stripe
    const signature = req.headers["stripe-signature"] as string;
    try {
      event = stripe.webhooks.constructEvent(
        req.body,
        signature,
        endpointSecret,
      );
    } catch (error) {
      //TODO email this to dev when it happens
      let userTransaction;
      if (event.data?.object?.id) {
        userTransaction = await prisma.payment.findFirst({
          where: {
            id: event.data.object.id,
          },
          select: {
            user: {
              select: {
                id: true,
              },
            },
          },
        });
      }
      await prisma.error.create({
        data: {
          ip: req.ip,
          userId: userTransaction?.user?.id,
          description: "Webhook signature verification failed error: " + error,
        },
      });
      log(`Webhook signature verification failed.` + error);
      return res.sendStatus(400);
    }
  }
  const dataObject = event.data.object;

  // process order
  if (event.type) {
    const now = new Date();
    //TODO get date for completed from from stripe
    if (
      event.type === "checkout.session.completed" ||
      event.type === "payment_intent.succeeded"
    ) {
      // This means the entire session was paid and we are good to add payment
      //Update that the payment was processed and then pass info needed for additonal processing for later
      const payment = await prisma.payment.update({
        where: {
          paymentIntent_type: {
            paymentIntent: dataObject.id,
            type: "STRIPE",
          },
        },
        data: {
          completed: now,
          paymentMethod: dataObject.payment_method,
        },
        select: {
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
      // //Throw out if completed not found
      if (!payment.completed) {
        throw new AppError("Payment failed.");
      }
      creditItems(payment, now);
    } else if (event.type === "invoice.payment_succeeded") {
      // Triggered when a payment for a subscription invoice is successfully processed.
      // This event indicates that a subscription payment has been made.
      if (dataObject["billing_reason"] == "subscription_create") {
        // The subscription automatically activates after successful payment
        // Set the payment method used to pay the first invoice
        // as the default payment method for that subscription
        const subscription_id = dataObject["subscription"];
        // Retrieve the payment intent used to pay the subscription
        const payment_intent_id = dataObject["payment_intent"];
        const payment_intent =
          await stripe.paymentIntents.retrieve(payment_intent_id);
        try {
          await stripe.subscriptions.update(subscription_id, {
            default_payment_method: payment_intent.payment_method as string,
          });
        } catch (err) {
          await prisma.error.create({
            data: {
              ip: req.ip,
              description:
                "WEBHOOK Failed to update default payment method, subscription_id: " +
                subscription_id +
                ", payment_intent_id: " +
                payment_intent_id,
            },
          });
          throw new AppError("Failed to update default payment method");
        }
      }
      if (dataObject["billing_reason"] == "subscription_cycle") {
        // This is a payment for an already active subscription
        const subscription_id = dataObject["subscription"];

        //Get expires and premiumAccessExpires
        //expires tracks the subscription expiration
        //premiumAccessExpires tracks the premium space expiration
        const subscription = await prisma.subscription.findUnique({
          where: {
            subscriptionId_type: {
              subscriptionId: subscription_id,
              type: "STRIPE",
            },
          },
          select: {
            id: true,
            expires: true,
            payDayAnchor: true,
            spaceMember: {
              select: {
                premiumAccessExpires: true,
              },
            },
          },
        });
        if (!subscription) {
          throw new AppError("Subscription not found");
        }

        //Calculate nextPayment, expires, and premiumAccessExpires
        const { nextPayment, expires, premiumAccessExpires } =
          await calculateSubscription(
            now,
            subscription.payDayAnchor,
            subscription.spaceMember?.premiumAccessExpires,
          );

        await prisma.subscription.update({
          where: {
            subscriptionId_type: {
              subscriptionId: subscription_id,
              type: "STRIPE",
            },
          },
          data: {
            nextPayment,
            expires,
            spaceMember: {
              update: {
                premiumAccessExpires,
              },
            },
          },
        });
      }
    } else if (event.type === "charge.refunded") {
      //TODO get chargeRefunded date from stripe
      // This turns off the customers premium and retracts coins if they get a refund through stripe
      const refund = await prisma.payment.update({
        where: {
          paymentIntent_type: {
            paymentIntent: dataObject.payment_intent,
            type: "STRIPE",
          },
        },
        data: {
          refunded: now,
        },
        select: {
          userId: true,
          paymentIntent: true,
          paymentMethod: true,
          type: true,
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
                          quantity: true,
                          premiumDays: true,
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
      if (!refund.userId) {
        throw new AppError("Refund user not found");
      }
      //decredit the orders items
      decreditOrder(refund, now);
    } else if (event.type === "invoice.paid") {
      // If the payment is successful, the invoice.paid event is sent.
      // Use this webhook to activate a subscription or fulfill an order.
    } else if (event.type === "invoice.payment_failed") {
      // If the payment fails or the customer does not have a valid payment method,
      //  an invoice.payment_failed event is sent, the subscription becomes past_due.
      // Use this webhook to notify your user that their payment has
      // failed and to retrieve new card details.
    } else if (event.type === "invoice.finalized") {
      // If you want to manually send out invoices to your customers
      // or store them locally to reference to avoid hitting Stripe rate limits.
    } else if (event.type === "customer.subscription.deleted") {
      if (event.request != null) {
        // handle a subscription cancelled by your request from above.
        const subscription = await prisma.subscription.update({
          where: {
            id: dataObject.id,
          },
          data: {
            nextPayment: null,
          },
        });
        if (!subscription) {
          await prisma.error.create({
            data: {
              ip: req.ip,
              description:
                "WEBHOOK Failed customer.subscription.deleted, dataObject.id: " +
                dataObject.id,
            },
          });
          res.status(400).end();
        }
      } else {
        // handle subscription cancelled automatically based upon your subscription settings. TODO make this work.
        await prisma.error.create({
          data: {
            ip: req.ip,
            description:
              "WEBHOOK Failed customer.subscription.deleted, dataObject.id: " +
              dataObject.id,
          },
        });
        res.status(400).end();
      }
    } else if (event.type === "customer.subscription.trial_will_end") {
      //Send notification to user that trial will end
      //We do not have trials yet so can ignore
    } else if (event.type === "payment_intent.created") {
      // Additional handling, such as updating your database or initiating pre-payment processes
      //Do not need as the paymentIntent is sent to our DB first
    } else if (event.type === "charge.succeeded") {
      // Update your system to reflect the successful payment
      // For example, update the order status, grant access to a product, send a confirmation email, etc.
    } else if (event.type === "customer.created") {
      //Triggered when a new customer is created.
    } else if (event.type === "customer.subscription.created") {
      //Triggered when a new subscription is created.
      //Subscriptions are also assigned at checkout.session.completed
      //This just makes sure the subscription exists and throws an error if it does not
      //Ideally this should not be needed but it is a safety check
      const transactionCheck = await prisma.subscription.findFirstOrThrow({
        where: {
          subscriptionId: dataObject.subscription,
        },
      });
      if (!transactionCheck) {
        await prisma.error.create({
          data: {
            ip: req.ip,
            description:
              "WEBHOOK Failed customer.subscription.created, dataObject.subscription: " +
              dataObject.subscription,
          },
        });
        throw new AppError("Subscription not found.");
      }
    } else if (
      event.type === "test_helpers.test_clock.deleted" ||
      event.type === "test_helpers.test_clock.created" ||
      event.type === "test_helpers.test_clock.advancing" ||
      event.type === "test_helpers.test_clock.ready"
    ) {
      //These are clock test events
    } else if (event.type === "mandate.updated") {
      // Triggered when a user changes how their payment is collected.
    } else {
      // This runs if nothing matches the above cases
      await prisma.error.create({
        data: {
          ip: req.ip,
          description:
            "Unhandled STRIPE_WEBHOOK: ," +
            event.type +
            ", dataObject.id: " +
            dataObject.id,
        },
      });
      throw new AppError(
        "Unhandled STRIPE_WEBHOOK: ," +
          event.type +
          ", dataObject.id: " +
          dataObject.id,
      );
    }
  }
  return res.send({
    ok: true,
  });
};

type Payment = {
  paymentIntent: string;
  paymentMethod: string | null;
  type: PaymentType;
  order: {
    total: number;
    user: {
      id: number;
      stripeCustomerId: string | null;
    };
    items: {
      quantity: number;
      price: number;
      product: {
        id: number;
        title: string;
        stripeProductId: string | null;
        type: ProductType;
        space: {
          id: number;
        } | null;
        coin: {
          quantity: number;
          premiumDays: number;
        } | null;
      };
    }[];
  };
};

//Send paid items here to process credits
export const creditItems = async (payment: Payment, now: Date) => {
  const order = payment.order;
  //run for each item then each quantity inside order. This allows correct accounting for premium days/coins in large orders
  for (const item of order.items) {
    //run items multiple times if quantity more than 1
    for (let a = 1; a <= item.quantity; a++) {
      //Process monthly subscription for stripe
      if (item.product.type === "MONTHLY_SUBSCRIPTION") {
        if (!item.product.space) {
          throw new AppError("Subscription Space not found");
        }

        let subscriptionId;

        if (
          payment.type === PaymentType.STRIPE &&
          item.product.stripeProductId
        ) {
          // Retrieve all subscriptions for the customer
          const subscriptions = await stripe.subscriptions.list({
            customer: order.user.stripeCustomerId ?? "",
          });

          // Check if there's an existing subscription for the product
          const existingSubscription = subscriptions.data.find((subscription) =>
            subscription.items.data.some(
              (stripeItem) =>
                stripeItem.price.id === item.product.stripeProductId,
            ),
          );

          if (existingSubscription) {
            subscriptionId = existingSubscription.id;
          } else {
            // If no existing subscription, create a new one
            //Attach payment method to customer
            await stripe.customers.update(order.user.stripeCustomerId ?? "", {
              invoice_settings: {
                default_payment_method: payment.paymentMethod ?? "",
              },
            });
            //Create subscription for future payments
            const stripeSubscription = await stripe.subscriptions.create({
              customer: order.user.stripeCustomerId ?? "",
              items: [
                {
                  price: item.product.stripeProductId,
                },
              ],
            });
            subscriptionId = stripeSubscription.id;
          }
        } else if (
          payment.type === PaymentType.APPLE ||
          payment.type === PaymentType.GOOGLE
        ) {
          // Apple/Google subscriptions are handled by the app stores
          //Use the userId and productId to track subscriptionId
          subscriptionId = `${order.user.id}_${item.product.id}`;
        }

        if (subscriptionId) {
          updateSubscription(
            subscriptionId,
            item.product.id,
            order.user.id,
            item.product.space.id,
            now,
          );
        }
      }

      //Process premium subscription
      if (item.product.type === "FOUNDERS_TOKEN") {
        const token = await prisma.product.findUnique({
          where: {
            id: item.product.id,
          },
          select: {
            id: true,
          },
        });
        if (!token) {
          throw new AppError("Item is unavailable");
        }
        const foundersSpace = await prisma.space.findUniqueOrThrow({
          where: {
            slug: "founders",
          },
          select: {
            id: true,
          },
        });
        //add to founders space if not added and do nothing if already added
        await prisma.spaceMember.upsert({
          where: {
            userId_spaceId: {
              userId: order.user.id,
              spaceId: foundersSpace.id,
            },
          },
          create: {
            userId: order.user.id,
            spaceId: foundersSpace.id,
          },
          update: {}, //do nothing
        });
      }
      //credit premium days NOTE that subscriptions come with 0 premiumDays so they do not affect this calculation
      if (item.product.coin?.premiumDays) {
        const premiumSpace = await prisma.space.findFirstOrThrow({
          where: {
            slug: "premium",
          },
          select: {
            id: true,
          },
        });
        const spaceMember = await prisma.spaceMember.upsert({
          where: {
            userId_spaceId: {
              userId: order.user.id,
              spaceId: premiumSpace.id,
            },
          },
          create: {
            userId: order.user.id,
            spaceId: premiumSpace.id,
          },
          update: {}, //do nothing
          select: {
            premiumAccessExpires: true,
          },
        });
        const premiumDaysToAdd = item.product.coin.premiumDays;
        let newPremiumAccessExpires;
        if (
          spaceMember.premiumAccessExpires &&
          new Date(spaceMember.premiumAccessExpires) > now
        ) {
          // If premiumAccessExpires is in the future, add premiumDays to it
          newPremiumAccessExpires = new Date(spaceMember.premiumAccessExpires);
          newPremiumAccessExpires.setDate(
            newPremiumAccessExpires.getDate() + premiumDaysToAdd,
          );
        } else {
          // If premiumAccessExpires does not exist or is in the past, set it to today + premiumDays
          newPremiumAccessExpires = new Date(now);
          newPremiumAccessExpires.setDate(
            newPremiumAccessExpires.getDate() + premiumDaysToAdd,
          );
        }
        await prisma.spaceMember.update({
          where: {
            userId_spaceId: {
              userId: order.user.id,
              spaceId: premiumSpace.id,
            },
          },
          data: {
            premiumAccessExpires: newPremiumAccessExpires,
          },
        });
      }
      //credit coins to user
      if (item.product.coin?.quantity) {
        const coinTronRatio = await prisma.siteSettings.findMany({
          select: {
            coinTronRatio: true,
          },
          orderBy: {
            createdAt: "desc",
          },
          take: 1,
        });
        await prisma.user.update({
          where: {
            id: order.user.id,
          },
          data: {
            coinsBalance: {
              increment: item.product.coin.quantity,
            },
            tronsBalance: {
              increment:
                item.product.coin.quantity * coinTronRatio[0].coinTronRatio,
            },
          },
        });
      }
    }
  }
  //send socket to all sessions of user
  const sessions = await prisma.session.findMany({
    where: {
      userId: order.user.id,
    },
    select: {
      socketId: true,
    },
  });
  const io = getIoInstance();
  sessions.forEach((session) => {
    if (session.socketId) {
      let message = `Order Complete Total: $${(order.total / 100).toFixed(2)}\n`;
      order.items.forEach((item) => {
        message += `${item.quantity} ${item.product.title} $${(item.price / 100).toFixed(2)}\n`;
      });
      io.to(session.socketId).emit("message", message);
      io.to(session.socketId).emit("refreshUser");
    }
  });
};

const decreditOrder = async (payment: Payment, now: Date) => {
  const order = payment.order;
  for (const item of order.items) {
    for (let a = 1; a <= item.quantity; a++) {
      // reverse premiumsdays from coins being refunded
      if (item.product.coin) {
        //TODO test this
        let premiumSpace;
        if (item.product.space?.id) {
          premiumSpace = await prisma.space.findUnique({
            where: {
              id: item.product.space.id,
            },
            select: {
              id: true,
            },
          });
        }
        if (!premiumSpace) {
          throw new AppError("Failed to find premium space");
        }
        const spaceMember = await prisma.spaceMember.findUnique({
          where: {
            userId_spaceId: {
              userId: order.user.id,
              spaceId: premiumSpace.id,
            },
          },
          select: {
            subscription: {
              select: {
                expires: true,
              },
            },
          },
        });
        if (!spaceMember || !spaceMember.subscription?.expires) {
          throw new AppError("Failed to find spaceMember");
        }
        let premiumExpires = new Date(spaceMember.subscription.expires);
        if (item.product.coin?.premiumDays) {
          premiumExpires.setDate(
            premiumExpires.getDate() - item.product.coin?.premiumDays,
          );
        }
        const coinTronRatio = await prisma.siteSettings.findMany({
          orderBy: {
            createdAt: "desc",
          },
          take: 1,
          select: {
            coinTronRatio: true,
          },
        });
        await prisma.user.update({
          where: {
            id: order.user.id,
          },
          data: {
            coinsBalance: {
              decrement: item.product.coin.quantity,
            },
            tronsBalance: {
              decrement:
                item.product.coin.quantity * coinTronRatio[0].coinTronRatio,
            },
          },
        });
        await prisma.spaceMember.update({
          where: {
            userId_spaceId: {
              userId: order.user.id,
              spaceId: premiumSpace.id,
            },
          },
          data: {
            subscription: {
              update: {
                expires: premiumExpires,
              },
            },
          },
        });
      }
    }
  }
};

const calculateSubscription = async (
  now: Date,
  payDayAnchor: number,
  premiumAccessExpiresOld: Date | null | undefined,
) => {
  //Set next payment date, this is when the next payment is expected
  let nextPayment = new Date(now);
  nextPayment.setMonth(nextPayment.getMonth() + 1);
  nextPayment.setDate(payDayAnchor);

  //Set expires date, this is when the subscription ends
  let expires = new Date(nextPayment);
  expires.setDate(expires.getDate() + 5);

  //Set premiumAccessExpires date, this is when the premium space access ends
  let premiumAccessExpires =
    !premiumAccessExpiresOld || premiumAccessExpiresOld <= now
      ? expires
      : nextMonth(premiumAccessExpiresOld);
  //NOTE
  //expires ends  the subscription
  //premiumAccessExpires ends the premium space access
  //premiumAccessExpires increases from coin purchases/receiving and other factors outside the subscription
  return {
    nextPayment,
    expires,
    premiumAccessExpires,
  };
};

const updateSubscription = async (
  subscriptionId: string,
  productId: number,
  userId: number,
  spaceId: number,
  now: Date,
) => {
  const { nextPayment, expires, premiumAccessExpires } =
    await calculateSubscription(now, now.getDate(), null);
  //Create subscription in our DB or query if it exists
  const subscription = await prisma.subscription.upsert({
    where: {
      subscriptionId_type: {
        subscriptionId: subscriptionId,
        type: PaymentType.STRIPE,
      },
    },
    create: {
      expires,
      subscriptionId: subscriptionId,
      payDayAnchor: now.getDate(),
      nextPayment,
      productId,
      userId,
      type: "STRIPE",
    },
    update: {}, //do nothing
    select: {
      id: true,
    },
  });
  //Create spaceMember in our DB or query if it exists then connect to subscription
  const spaceMember = await prisma.spaceMember.upsert({
    where: {
      userId_spaceId: {
        userId,
        spaceId,
      },
    },
    create: {
      userId,
      spaceId,
      subscriptionId: subscription.id,
      premiumAccessExpires,
    },
    update: {
      premiumAccessExpires,
    },
  });
};
