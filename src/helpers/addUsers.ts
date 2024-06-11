import prisma from "../clients/prisma";
import { faker } from "@faker-js/faker";
import log from "./log";

const addUsers = async (quantity: number) => {
  let count = 0;
  for (let i = 0; i < quantity; i++) {
    const username = faker.internet.userName();
    const check = await prisma.user.findFirst({
      where: {
        username,
      },
    });
    if (!check) {
      if (i % 100 === 0) {
        log("info", "Added " + count + " users to DB");
      }
      count++;
      await prisma.user.create({
        data: {
          username: faker.internet.userName(),
          name: faker.person.fullName(),
          password: faker.internet.password(),
          email: faker.internet.email(),
          bio: faker.lorem.paragraph(),
        },
      });
    }
  }
  log("success", "Added " + count + " users to DB");
};

export default addUsers;
