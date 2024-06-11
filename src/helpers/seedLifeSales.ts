import prisma from "../clients/prisma";
import log from "./log";

// Seeds x Life Time Premium purchases
const seedLifeSales = async (amount: number) => {
  log("Starting Coin Transaction Seed Function");
  const lifeCoin = await prisma.product.findFirstOrThrow({
    where: {
      type: "FOUNDERS_TOKEN",
      active: true,
    },
  });
  const janice = await prisma.user.findFirstOrThrow({
    where: {
      username: "Janice.Kling78",
    },
  });
  for (let i = 1; i <= amount; i++) {
    await prisma.order.create({
      data: {
        userId: janice.id,
        total: 10000,
        payments: {
          create: {
            paymentIntent: "test" + i,
            completed: new Date("1-1-1969"),
            userId: janice.id,
            type: "STRIPE",
            amount: 10000,
          },
        },
        items: {
          create: {
            price: lifeCoin.price,
            discount: 0,
            quantity: 1,
            productId: lifeCoin.id,
          },
        },
      },
    });
    if (i % 100 === 0) {
      log("Generated " + i + " transactions");
    }
  }
  log("Seed Function Completed");
};

export default seedLifeSales;
