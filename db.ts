#!/usr/bin/env node

// run with: ts-node cli seed

// These reconfigure .js lint to work with the auto lint in VSCode
/* eslint-disable no-unused-expressions */
/* eslint indent: ["error", 4] */
/* eslint space-before-function-paren: ["error", "never"] */

import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { prisma } from "./src/clients/prisma";
import log from "./src/helpers/log";

yargs(hideBin(process.argv))
  .command("check", "Check unique constraints on DB", {}, (argv) => {
    log("info", "Checking unique constraints on DB");
    checkDB();
  })
  .command("fix", "Fix unique constraints on DB", {}, (argv) => {
    log("info", "Fixing unique constraints on DB");
    prepareDB();
  })
  .command(
    "checkContent",
    "Check for content > 8191b in database",
    {},
    (argv) => {
      log("info", "Checking for content > 8191b in database");
      checkContent();
    },
  )
  .command("fixContent", "Fix content > 8191b in database", {}, (argv) => {
    log("info", "Fixing content > 8191b in database");
    fixContent();
  }).argv;

async function checkDB() {
  const spaceIds: { spaceIds: number }[] = await prisma.$queryRaw`
        SELECT "spaceId", slug, COUNT(*)
        FROM "Factiii"
        GROUP BY "spaceId", slug
        HAVING COUNT(*) > 1;
    `;
  log("info", "Duplicated spaceIds: " + spaceIds.length);

  const userIds: { userIds: number }[] = await prisma.$queryRaw`
        SELECT "userId", slug, COUNT(*)
        FROM "Factiii"
        GROUP BY "userId", slug
        HAVING COUNT(*) > 1;
    `;
  log("info", "Duplicated userIds:" + userIds.length);
}

async function prepareDB() {
  const factiiiDoubles: { spaceId: number; slug: string; count: number }[] =
    await prisma.$queryRaw`
    SELECT "spaceId", slug, COUNT(*)
    FROM "Factiii"
    GROUP BY "spaceId", slug
    HAVING COUNT(*) > 1;
    `;
  log("info", "Duplicated spaceIds:" + factiiiDoubles);
  const factiiiDoublesCount = factiiiDoubles.length;
  log("info", "Duplicated spaceIds:" + factiiiDoublesCount);
  let processedFactiiiDoubles = 0;
  for (const factiii of factiiiDoubles) {
    processedFactiiiDoubles++;
    if (processedFactiiiDoubles % 25 === 0) {
      log(
        "info",
        "Processed " +
          processedFactiiiDoubles +
          " of " +
          factiiiDoublesCount +
          " Duplicated spaceIds",
      );
    }
    //find factiiis with no postFactiiis and delete
    await prisma.factiii.deleteMany({
      where: {
        spaceId: factiii.spaceId,
        slug: factiii.slug,
        factiiis: {
          none: {},
        },
      },
    });
    // find factiiis with postFactiiis and combine into 1 factiii
    let factiiiIds: number[] = [];
    const postFactiiiis = await prisma.postFactiii.findMany({
      where: {
        factiii: {
          spaceId: factiii.spaceId,
          slug: factiii.slug,
        },
      },
      select: {
        id: true,
        postId: true,
        userId: true,
        factiiiId: true,
      },
    });
    for (const postFactiiii of postFactiiiis) {
      if (!factiiiIds.includes(postFactiiii.factiiiId)) {
        factiiiIds.push(postFactiiii.factiiiId);
      }
      // check postFactii is unique
      const uniquePostFactiiis = await prisma.postFactiii.findMany({
        where: {
          postId: postFactiiii.postId,
          userId: postFactiiii.userId,
          OR: [
            { factiiiId: postFactiiii.factiiiId },
            { factiiiId: factiiiIds[0] },
          ],
        },
      });
      //delete all but 1 non unique postFactiiis
      for (const nonUniquePostFactiii of uniquePostFactiiis.slice(1)) {
        await prisma.postFactiii.delete({
          where: {
            id: nonUniquePostFactiii.id,
          },
        });
      }
      //set first factiii found as factiii for all postFactiiis
      const checkPostFactiii = await prisma.postFactiii.findFirst({
        where: {
          id: postFactiiii.id,
        },
        select: {
          id: true,
        },
      });
      if (checkPostFactiii) {
        await prisma.postFactiii.update({
          where: {
            id: postFactiiii.id,
          },
          data: {
            factiiiId: factiiiIds[0],
          },
        });
      }
      //Last postFactiii delete orphaned factiiis
      if (
        postFactiiii === postFactiiiis[postFactiiiis.length - 1] &&
        factiiiIds.length > 1
      ) {
        //update factiii space to wikipedia
        await prisma.factiii.update({
          where: {
            id: factiiiIds[0],
          },
          data: {
            spaceId: 15,
          },
        });
        //delete orphaned factiiis
        for (const factiiiId of factiiiIds.slice(1)) {
          await prisma.factiii.delete({
            where: {
              id: factiiiId,
            },
          });
        }
      }
    }
  }

  log("info", "Fixing wikis with no spaceId");
  // assign all factiiis with no space and user wikipedia to wikipedia space
  await prisma.factiii.updateMany({
    where: {
      userId: 30, //30=wikipedia user
      spaceId: null,
    },
    data: {
      spaceId: 15, //15=wikipedia space
    },
  });

  log("info", "DONE");
}

async function checkContent() {
  const result = await prisma.$queryRaw`
        SELECT id, LENGTH(content) AS char_length, OCTET_LENGTH(content) AS byte_length
        FROM "Post"
        WHERE OCTET_LENGTH(content) > 8191
        ORDER BY OCTET_LENGTH(content) DESC;
            
    `;
  log("info", "Result :" + result);
}

async function fixContent() {
  // Gather factiiiIds associated with Posts over the limit
  const postIdsForDeletion: { id: any }[] = await prisma.$queryRaw`
    SELECT "id"
    FROM "Post"
    WHERE LENGTH("content") > 4000;
    `;

  const postIdsForDeletionCount = postIdsForDeletion.length;
  log("info", "Deleting: " + postIdsForDeletionCount + " Posts over the limit");

  let deletedFactiiis: number = 0;
  let deletedPosts: number = 0;
  let deletedPostFactiiis: number = 0;
  for (const postId of postIdsForDeletion) {
    // Delete all "PostFactiii" associated with the "Post" over the limit
    const postFactiiis = await prisma.postFactiii.findMany({
      where: {
        postId: postId.id,
      },
      select: {
        id: true,
        factiiiId: true,
      },
    });
    for (const postFactiii of postFactiiis) {
      deletedPostFactiiis++;
      await prisma.postFactiii.delete({
        where: {
          id: postFactiii.id,
        },
      });
      const postsCount = await prisma.postFactiii.count({
        where: {
          factiiiId: postFactiii.factiiiId,
        },
      });
      if (postsCount === 0) {
        // Delete orphaned "Factiii"
        deletedFactiiis++;
        await prisma.factiii.delete({
          where: {
            id: postFactiii.factiiiId,
          },
        });
      }
    }
    // Delete the offensive Post
    deletedPosts++;
    if (deletedPosts % 100 === 0) {
      log(
        "info",
        "Deleted " +
          deletedPosts +
          " of " +
          postIdsForDeletionCount +
          " Posts.",
      );
    }
    await prisma.post.delete({
      where: {
        id: postId.id,
      },
    });
  }
  log("info", "Deleted Posts:" + deletedPosts);
  log("info", "Deleted PostFactiiis:" + deletedPostFactiiis);
  log("info", "Deleted Factiiis:" + deletedFactiiis);
}
