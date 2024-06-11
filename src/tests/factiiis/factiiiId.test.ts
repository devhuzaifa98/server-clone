import { beforeAll, describe, expect, it } from "@jest/globals";
import { Factiii, Post, Space, User } from "@prisma/client";
import request from "supertest";
import { app } from "../../app";
import prisma from "../../clients/prisma";
import stringToSlug from "../../helpers/stringToSlug";

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

    privateFactiiiSpace = await prisma.space.findUniqueOrThrow({
      where: {
        slug: "private-factiii",
      },
    });

    privateFactiii = await prisma.factiii.findUniqueOrThrow({
      where: {
        spaceId_userId_slug_requirements: {
          spaceId: privateFactiiiSpace.id,
          userId: janiceUser.id,
          slug: stringToSlug("Private Factiii"),
          requirements: ["NONE"],
        },
      },
    });

    publicFactiii = await prisma.factiii.findUniqueOrThrow({
      where: {
        spaceId_userId_slug_requirements: {
          spaceId: privateFactiiiSpace.id,
          userId: janiceUser.id,
          slug: stringToSlug("Public Factiii"),
          requirements: ["NONE"],
        },
      },
    });

    privatePost = await prisma.post.findFirstOrThrow({
      where: {
        content:
          "Private post in s/private_Factiii with a private and public factiii attached. If you see me then something is broken.",
      },
    });

    publicPost = await prisma.post.findFirstOrThrow({
      where: {
        content:
          "Public post in s/factiii with a private and public factiii attached.",
      },
    });
  });
  it("/${factiiiId} janice searches science id 20} ", async () => {
    const res = await request(app)
      .get(`/factiiis/posts?factiiiIds=20`)
      .set("Authorization", `Bearer ${janiceToken}`);
    const posts: Post[] = res.body.posts;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("posts");
    expect(Array.isArray(res.body.posts)).toBe(true);
    expect(posts.length === 4).toBe(true);
    expect(
      posts.some(
        (post) => post.content === "Post with factiiis science and politics",
      ),
    ).toBe(true);
    expect(
      posts.some(
        (post) => post.content === "Post with factiiis science and history",
      ),
    ).toBe(true);
    expect(
      posts.some(
        (post) => post.content === "Post with factiiis science and ford",
      ),
    ).toBe(true);
    expect(
      posts.some(
        (post) => post.content === "Post with factiiis science and technology",
      ),
    ).toBe(true);
  });
  it("/slug janice searches history by factiiiId 19", async () => {
    const res = await request(app)
      .get(`/factiiis/posts?factiiiIds=19`)
      .set("Authorization", `Bearer ${janiceToken}`);
    const posts: Post[] = res.body.posts;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("posts");
    expect(Array.isArray(res.body.posts)).toBe(true);
    expect(posts.length === 2).toBe(true);
    expect(
      posts.some(
        (post) => post.content === "Post with factiiis science and history",
      ),
    ).toBe(true);
    expect(
      posts.some((post) => post.content === "This is a post about history."),
    ).toBe(true);
  });
  it("/factiiiId/posts janice searches 21=ford", async () => {
    const res = await request(app)
      .get(`/factiiis/posts?factiiiIds=21`)
      .set("Authorization", `Bearer ${janiceToken}`);
    const posts: Post[] = res.body.posts;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("posts");
    expect(Array.isArray(res.body.posts)).toBe(true);
    expect(posts.length === 1).toBe(true);
    expect(
      posts.some(
        (post) => post.content === "Post with factiiis science and ford",
      ),
    ).toBe(true);
  });
  it("/factiiiId/posts janice searches private", async () => {
    const res = await request(app)
      .get(`/factiiis/posts?factiiiIds=${privateFactiii.id}`)
      .set("Authorization", `Bearer ${janiceToken}`);
    const posts: Post[] = res.body.posts;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("posts");
    expect(Array.isArray(res.body.posts)).toBe(true);
    expect(posts.length === 2).toBe(true);
    expect(
      posts.some(
        (post) =>
          post.content ===
          "Public post in s/factiii with a private and public factiii attached.",
      ),
    ).toBe(true);
    expect(
      posts.some(
        (post) =>
          post.content ===
          "Private post in s/private_Factiii with a private and public factiii attached. If you see me then something is broken.",
      ),
    ).toBe(true);
  });
  it("/factiiiId/posts jon searches private", async () => {
    const res = await request(app)
      .get(`/factiiis/posts?factiiiIds=${privateFactiii.id}`)
      .set("Authorization", `Bearer ${jonToken}`);
    const posts: Post[] = res.body.posts;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("posts");
    expect(Array.isArray(res.body.posts)).toBe(true);
    expect(posts.length === 1).toBe(true);
    expect(
      posts.some(
        (post) =>
          post.content ===
          "Public post in s/factiii with a private and public factiii attached.",
      ),
    ).toBe(true);
  });
  it("/factiiiId/posts random user searches private", async () => {
    const res = await request(app).get(
      `/factiiis/posts?factiiiIds=${privateFactiii.id}`,
    );
    const posts: Post[] = res.body.posts;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("posts");
    expect(Array.isArray(res.body.posts)).toBe(true);
    expect(posts.length === 1).toBe(true);
    expect(
      posts.some(
        (post) =>
          post.content ===
          "Public post in s/factiii with a private and public factiii attached.",
      ),
    ).toBe(true);
  });
});
