import { describe, expect, test, it } from "@jest/globals";
import request from "supertest";
import { app } from "../app";
import fs from "fs";
import path from "path";

// List of whitelisted files for console.log test
const whitelist = ["basic.test.ts", "log.ts"];

const checkForConsoleLog = (file: any) => {
  const fileContent = fs.readFileSync(file, "utf-8");
  const regex = /console\.log\(/g;

  if (regex.test(fileContent)) {
    throw new Error(`console.log found in ${file}`);
  }
};

const readDirectory = (dir: any) => {
  const files = fs.readdirSync(dir);

  files.forEach((file) => {
    const filePath = path.join(dir, file);
    const isDirectory = fs.statSync(filePath).isDirectory();

    if (isDirectory) {
      readDirectory(filePath);
    } else {
      if (!whitelist.includes(file)) {
        checkForConsoleLog(filePath);
      }
    }
  });
};

describe("Basic Tests", () => {
  it("/unknown-route hits a non-existent route", async () => {
    const res = await request(app).get("/unknown-route");
    expect(res.statusCode).toBe(403);
    expect(res.body.error).toBe(true);
  });
  it("/search/posts?query=private check if post search reveals hidden post in private test", async () => {
    const res = await request(app).get("/search/posts?query=private");
    expect(res.statusCode).toBe(200);
    expect(res.body.posts.length).toBe(1); //the 1 post is a privateFactiii check
  });
  it("/search/posts?query=removed check if post search reveals removed post from janice", async () => {
    const res = await request(app).get("/search/posts?query=removed");
    expect(res.statusCode).toBe(200);
    expect(res.body.posts[0].content.includes("removed")).toBe(false);
    expect(res.body.posts[0].content.includes("Withdrawn ")).toBe(true);
  });
  test("check for console.log calls in non-whitelisted files", () => {
    const rootDir = path.resolve(__dirname, "..");
    expect(() => readDirectory(rootDir)).not.toThrow();
  });
});
