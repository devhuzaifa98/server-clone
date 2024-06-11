import { describe, expect, beforeAll, it } from "@jest/globals";
import request from "supertest";
import { app } from "../../app";
import prisma from "../../clients/prisma";
import { Factiii, Post, Space, User } from "@prisma/client";
import log from "../../helpers/log";

describe("factiiis/factiiiId/post route", () => {
  let jonUser: User;
  let janiceUser: User;
  let jonToken: string;
  let janiceToken: string;
  let privateFactiiiSpace: Space;
  let privateFactiii: Factiii;
  let publicFactiii: Factiii;
  let privatePost: Post;
  let publicPost: Post;

  beforeAll(async () => {
    jonUser = await prisma.user.findUniqueOrThrow({
      where: {
        username: "jon",
      },
    });

    janiceUser = await prisma.user.findUniqueOrThrow({
      where: {
        username: "janice78",
      },
    });

    const jonRes = await request(app)
      .post("/auth/login")
      .send({ username: "jon", password: "catcatcat" });
    expect(jonRes.statusCode).toBe(200);
    expect(jonRes.body).toHaveProperty("credentials");
    jonToken = jonRes.body.credentials.access;

    const janiceRes = await request(app)
      .post("/auth/login")
      .send({ username: "janice78", password: "catcatcat" });
    expect(janiceRes.statusCode).toBe(200);
    expect(janiceRes.body).toHaveProperty("credentials");
    janiceToken = janiceRes.body.credentials.access;
  });
  it("5x runs with janice /posts/trending?page=0&type=trending", async () => {
    for (let i = 0; i < 5; i++) {
      const start = Date.now();

      const res = await request(app)
        .get(`/posts/trending?page=0&type=trending`)
        .set("Authorization", `Bearer ${janiceToken}`);
      //const posts: Post[] = res.body.posts;

      const end = Date.now();
      const elapsedTime = end - start;

      log(`Run ${i + 1} with janice took: ${elapsedTime}ms`);
      expect(elapsedTime).toBeLessThan(1000);
      expect(res.statusCode).toBe(200);
    }
  });

  it("5x runs with no user /posts/trending?page=0&type=trending", async () => {
    for (let i = 0; i < 5; i++) {
      const start = Date.now();

      const res = await request(app).get(
        `/posts/trending?page=0&type=trending`,
      );
      //const posts: Post[] = res.body.posts;

      const end = Date.now();
      const elapsedTime = end - start;

      log(`Run ${i + 1} with no user took: ${elapsedTime}ms`);
      expect(elapsedTime).toBeLessThan(1000);
      expect(res.statusCode).toBe(200);
    }
  });
});
