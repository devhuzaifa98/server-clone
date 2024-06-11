// run with: ts-node cli seed
import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { prisma } from "./src/clients/prisma";
import OpenAI from "openai";
import seedDataBase from "./src/helpers/seedDataBase";
import seedLifeSales from "./src/helpers/seedLifeSales";
import addUsers from "./src/helpers/addUsers";
import spaces from "./src/helpers/addSpaces";
import factiiis from "./src/helpers/seedFactiiis";
import log from "./src/helpers/log";
import scrapeArticle from "./src/bots/wikipedia/helpers/scrapeArticle";

yargs(hideBin(process.argv))
  .command("sql", "Run sql on database", {}, (argv) => {
    log("Running sql on the database");
    sql();
  })
  .command("seed", "Seed the database", {}, (argv) => {
    log("Seeding the database");
    seedDataBase();
  })
  .command("testScraper", "Test the scraper", {}, (argv) => {
    log("Testing the scraper");
    testScraper();
  })
  .command("getOpenAIModels", "Get all openAI Models", {}, (argv) => {
    log("Getting OpenAI Models...");
    getOpenAIModels();
  })
  .command(
    "seedLifeSales",
    "Seed X LifeSales",
    (yargs) => {
      return yargs.positional("amount", {
        describe: "Number of LifeSales to add",
        type: "number",
      });
    },
    (argv) => {
      const amount = argv.amount;
      log("Seeding X LifeSales");
      seedLifeSales(amount as number);
    },
  )
  .command(
    "factiiis <quantity>",
    "Add X wikis to DB",
    (yargs) => {
      yargs.positional("quantity", {
        describe: "Number of wikis to add",
        type: "number",
      });
    },
    (argv) => {
      log("info", "Adding " + argv.quantity + " wikis to DB");
      factiiis(argv.quantity as number);
    },
  )
  .command(
    "users <quantity>",
    "Add X users to DB",
    (yargs) => {
      yargs.positional("quantity", {
        describe: "Number of users to add",
        type: "number",
      });
    },
    (argv) => {
      log("info", "Adding " + argv.quantity + " users to DB");
      addUsers(argv.quantity as number);
    },
  )
  .command(
    "spaces <quantity>",
    "Add X spaces to DB",
    (yargs) => {
      yargs.positional("quantity", {
        describe: "Number of spaces to add",
        type: "number",
      });
    },
    (argv) => {
      log("info", "Adding " + argv.quantity + " spaces to DB");
      spaces(argv.quantity as number);
    },
  ).argv;

async function sql() {
  const result = await prisma.$queryRaw`
    SELECT conname AS constraint_name 
    FROM pg_constraint 
    INNER JOIN pg_class ON pg_constraint.conrelid = pg_class.oid 
    WHERE pg_class.relname = 'Post' AND conname = 'Post_pkey';    
    `;
  log(result as string);
}

// Gets all avaialble OpenAI Models
async function getOpenAIModels() {
  log("Getting OpenAI Models List");
  const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY, // This is also the default, can be omitted
  });
  const models = await openai.models.list({});
  log("models: " + models.data);
}

async function testScraper() {
  const url =
    "https://en.wikipedia.org/wiki/Reflex_arc#Monosynaptic_vs._polysynaptic";
  // const url = "https://en.wikipedia.org/wiki/Hrabri-class_submarine";
  const data = await scrapeArticle(url);
}
