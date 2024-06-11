import prisma from "../clients/prisma";

const paid = async (userId: number) => {
  //find all posts from user and select the awards
  const posts = await prisma.post.findMany({
    where: {
      userId,
    },
    select: {
      awards: {
        select: {
          coin: {
            select: {
              product: {
                select: {
                  price: true,
                },
              },
            },
          },
        },
      },
    },
  });
  //find all completed payments from user ever
  const payments = await prisma.payment.findMany({
    where: {
      userId,
      NOT: {
        completed: null,
      },
    },
    select: {
      order: {
        select: {
          items: {
            select: {
              product: {
                select: {
                  price: true,
                },
              },
            },
          },
        },
      },
    },
  });
  //sum the total cost of the received awards and the paid for products
  let totalPaid: number = 0;
  for (let post of posts) {
    for (let award of post.awards) {
      totalPaid += award.coin.product.price;
    }
  }
  for (let payment of payments) {
    for (let item of payment.order.items) {
      totalPaid += item.product.price;
    }
  }

  return totalPaid;
};

export default paid;
