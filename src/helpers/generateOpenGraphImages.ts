import puppeteer from "puppeteer";

export const generatePostOGImage = async (postId: string) => {
  const browser = await puppeteer.launch({
    headless: "new",
  });

  const page = await browser.newPage();

  await page.setViewport({
    height: 200,
    width: 1200,
  });

  await page.goto(`${process.env.CLIENT_APP_URL}/embed/post/${postId}`, {
    waitUntil: "networkidle2",
  });

  const main = await page.$("#main-embed");

  const base64 = await main?.screenshot({
    encoding: "base64",
    captureBeyondViewport: false,
  });

  return base64;
};

export const generateProfileOGImage = async (username: string) => {
  const browser = await puppeteer.launch({
    headless: "new",
  });

  const page = await browser.newPage();

  await page.setViewport({
    height: 200,
    width: 1200,
  });

  await page.goto(`${process.env.CLIENT_APP_URL}/embed/profile/${username}`, {
    waitUntil: "networkidle2",
  });

  const main = await page.$("#main-embed");

  const base64 = await main?.screenshot({
    encoding: "base64",
    captureBeyondViewport: false,
  });

  return base64;
};

export const generateSpaceOGImage = async (slug: string) => {
  const browser = await puppeteer.launch({
    headless: "new",
  });

  const page = await browser.newPage();

  await page.setViewport({
    height: 200,
    width: 1200,
  });

  await page.goto(`${process.env.CLIENT_APP_URL}/embed/space/${slug}`, {
    waitUntil: "networkidle2",
  });

  const main = await page.$("#main-embed");

  const base64 = await main?.screenshot({
    encoding: "base64",
    captureBeyondViewport: false,
  });

  return base64;
};

export const generateFactiiiOGImage = async (slug: string) => {
  const browser = await puppeteer.launch({
    headless: "new",
  });

  const page = await browser.newPage();

  await page.setViewport({
    height: 200,
    width: 1200,
  });

  await page.goto(`${process.env.CLIENT_APP_URL}/embed/factiii/${slug}`, {
    waitUntil: "networkidle2",
  });

  const main = await page.$("#main-embed");

  const base64 = await main?.screenshot({
    encoding: "base64",
    captureBeyondViewport: false,
  });

  return base64;
};
