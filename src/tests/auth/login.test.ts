import { describe, expect, test, it } from "@jest/globals";
import request from "supertest";
import { app } from "../../app";

describe("POST /auth/login", () => {
  let jonToken: string;
  let janiceToken: string;
  it("login using jon's credentials", async () => {
    const res = await request(app)
      .post("/auth/login")
      .send({ username: "jon", password: "catcatcat" });
    expect(res.statusCode).toBe(200);
    expect(Boolean(res.body.credentials)).toBe(true);
    expect(typeof res.body.credentials.access).toBe("string");
    expect(typeof res.body.credentials.refresh).toBe("string");

    jonToken = res.body.credentials.access;
  });
  it("login using incorrect credentials", async () => {
    const res = await request(app)
      .post("/auth/login")
      .send({ username: "jon", password: "wrong" });
    expect(res.statusCode).toBe(400);
    expect(Boolean(res.body.credentials)).toBe(false);
  });
  test("/reports/all as jon, make an authorized request ", async () => {
    const res = await request(app)
      .get("/reports/all")
      .set("Authorization", `Bearer ${jonToken}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body.reports)).toBe(true);
    expect(res.body.reports.length === 0).toBe(true);
  });
  test("check filters activate while logged in as jon", async () => {
    const res = await request(app)
      .get("/search/posts?query=removed")
      .set("Authorization", `Bearer ${jonToken}`);

    expect(res.statusCode).toBe(200);
    expect(res.body.posts[0].content.includes("something is broken")).toBe(
      false,
    );
    expect(res.body.posts[0].content.includes("Withdrawn")).toBe(true);
  });
  it("login using janice's credentials", async () => {
    const res = await request(app)
      .post("/auth/login")
      .send({ username: "janice78", password: "catcatcat" });
    expect(res.statusCode).toBe(200);
    expect(Boolean(res.body.credentials)).toBe(true);
    expect(typeof res.body.credentials.access).toBe("string");
    expect(typeof res.body.credentials.refresh).toBe("string");

    janiceToken = res.body.credentials.access;
  });
  test("make an unauthorized request to /reports/all with janices token", async () => {
    const res = await request(app)
      .get("/reports/all")
      .set("Authorization", `Bearer ${janiceToken}`);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body.reports)).toBe(true);
    expect(res.body.reports.length).toBe(0);
  });
});
