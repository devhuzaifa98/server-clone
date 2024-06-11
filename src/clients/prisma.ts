import { PrismaClient } from "@prisma/client";
import fs from "fs";
import path from "path";
import log from "../helpers/log";

const packageJson = JSON.parse(
  fs.readFileSync(path.resolve(__dirname, "../../package.json"), "utf8"),
);
const version = packageJson.version;

const prisma = new PrismaClient({});

//Find slow queries
// const prisma = new PrismaClient({
//   log: [
//     {
//       emit: 'event',
//       level: 'query',
//     },
//   ],
// });

// prisma.$on('query', (e) => {
//   log('Query:', e.query);
//   log('Duration:', e.duration);
//   log('Parameters:', JSON.stringify(e.params, null, 2));
// });

export const testDatabaseConnection = async () => {
  try {
    const r: any[] = await prisma.$queryRaw`SELECT 1`;
    if (r.length === 0)
      return log("Connection to database failed. Please restart the server.");
    log(`App Version: ${version}`);
    return log("Connected to database.");
  } catch (error) {
    log("error", error as string);
    process.exit(1);
  }
};

export default prisma; // default export
export { prisma }; // named export for cli.js
