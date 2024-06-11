import { beforeAll, describe, expect, it } from "@jest/globals";
import { Factiii, Post, Space, User } from "@prisma/client";
import request from "supertest";
import { app } from "../../app";
import prisma from "../../clients/prisma";
import log from "../../helpers/log";
import stringToSlug from "../../helpers/stringToSlug";

describe("myFactiiiTags.test.ts factiiis/myFactiiiTags/:post.uuid", () => {
  let jonUser: User;
  let janiceUser: User;
  let jonToken: string;
  let janiceToken: string;
  let privateFactiiiSpace: Space;
  let privateFactiii: Factiii | null;
  let publicFactiii: Factiii | null;
  let privatePost: Post | null;
  let publicPost: Post | null;

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

    privateFactiii = await prisma.factiii.findUnique({
      where: {
        spaceId_userId_slug_requirements: {
          spaceId: privateFactiiiSpace.id,
          userId: janiceUser.id,
          slug: stringToSlug("Private Factiii"),
          requirements: ["NONE"],
        },
      },
    });

    publicFactiii = await prisma.factiii.findUnique({
      where: {
        spaceId_userId_slug_requirements: {
          spaceId: privateFactiiiSpace.id,
          userId: janiceUser.id,
          slug: stringToSlug("Public Factiii"),
          requirements: ["NONE"],
        },
      },
    });

    privatePost = await prisma.post.findFirst({
      where: {
        content:
          "Private post in s/private_Factiii with a private and public factiii attached. If you see me then something is broken.",
      },
    });

    publicPost = await prisma.post.findFirst({
      where: {
        content:
          "Public post in s/factiii with a private and public factiii attached.",
      },
    });

    //Print out variables used in routes
    log("privatePost.uuid" + privatePost?.uuid ?? "privatePost.uuid IS NULL");
    log("publicPost.uuid" + publicPost?.uuid ?? "publicPost.uuid IS NULL");
    log("jonToken" + jonToken);
    log("janiceToken" + janiceToken);
  });
  it("publicPost.uuid Should respond with a list of factiiis for jon", async () => {
    const res = await request(app)
      .get(`/factiiis/myFactiiiTags/${publicPost?.uuid}`)
      .set("Authorization", `Bearer ${jonToken}`);
    const factiiis: Factiii[] = res.body.factiiiTags;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("factiiiTags");
    expect(Array.isArray(res.body.factiiiTags)).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Funny")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Informative")).toBe(
      true,
    );
    expect(factiiis.some((factiii) => factiii.name === "Troll")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Politics")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Misleading")).toBe(
      true,
    );
    expect(factiiis.some((factiii) => factiii.name === "NSFW")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "For Sale")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Count Calories")).toBe(
      true,
    );
    expect(factiiis.some((factiii) => factiii.name === "Work Out")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Run")).toBe(true);
  });
  it("publicPost.uuid Should respond with a list of factiiis for janice78", async () => {
    const res = await request(app)
      .get(`/factiiis/myFactiiiTags/${publicPost?.uuid}`)
      .set("Authorization", `Bearer ${janiceToken}`);
    const factiiis: Factiii[] = res.body.factiiiTags;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("factiiiTags");
    expect(Array.isArray(res.body.factiiiTags)).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Funny")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Informative")).toBe(
      true,
    );
    expect(factiiis.some((factiii) => factiii.name === "Troll")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Politics")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Misleading")).toBe(
      true,
    );
    expect(factiiis.some((factiii) => factiii.name === "NSFW")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "For Sale")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Count Calories")).toBe(
      true,
    );
    expect(factiiis.some((factiii) => factiii.name === "Work Out")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Run")).toBe(true);
  });
  it("privatePost.uuid Should not respond with factiii tags on jon", async () => {
    const res = await request(app)
      .get(`/factiiis/myFactiiiTags/${privatePost?.uuid}`)
      .set("Authorization", `Bearer ${jonToken}`);

    expect(res.statusCode).toBe(400);
  });
  it("privatePost.uuid Should not respond with factiii tags when logged in as jon", async () => {
    const res = await request(app)
      .get(`/factiiis/myFactiiiTags/${privatePost?.uuid}`)
      .set("Authorization", `Bearer ${jonToken}`);

    expect(res.statusCode).toBe(400);
  });
  it("privatePost.uuid Should respond with a list of factiii tags for privateFactiiiPost as janice", async () => {
    const res = await request(app)
      .get(`/factiiis/myFactiiiTags/${privatePost?.uuid}`)
      .set("Authorization", `Bearer ${janiceToken}`);
    const factiiis: Factiii[] = res.body.factiiiTags;

    expect(res.statusCode).toBe(200);
    expect(res.body).toHaveProperty("factiiiTags");
    expect(Array.isArray(res.body.factiiiTags)).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Jonathan Snyder")).toBe(
      false,
    );
    expect(factiiis.some((factiii) => factiii.name === "Funny")).toBe(true);
    expect(factiiis.some((factiii) => factiii.name === "Informative")).toBe(
      true,
    );
  });
  it("privatePost.uuid Should not respond wit when not logged in", async () => {
    const res = await request(app).get(
      `/factiiis/myFactiiiTags/${privatePost?.uuid}`,
    );
    expect(res.statusCode).toBe(400);
  });
});
