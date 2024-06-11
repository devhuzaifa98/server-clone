import { FactiiiRequirement, SpaceTime } from "@prisma/client";
import prisma from "../clients/prisma";
import { submitReport } from "./submitReport";

type PostFactiiiUpload = {
  url: string;
  key: string;
  id: string;
  type: "IMAGE" | "VIDEO" | "DOCUMENT";
};

export type PostFactiiiTag = {
  data: string;
  spaceTimes: SpaceTime[];
  anonymous: boolean;
  uploads: PostFactiiiUpload[] | null;
  factiiiId: number;
};

export const processFactiiis = async (
  userId: number,
  post: {
    id: number;
    userId: number;
  },
  addFactiiis: PostFactiiiTag[],
  removeFactiiiIds: number[],
) => {
  for (const postFactiii of addFactiiis) {
    // upsert without handling spaceTimes
    const factiii = await prisma.factiii.findUnique({
      where: {
        id: postFactiii.factiiiId,
      },
    });

    // Skip if factiii is not found
    if (!factiii) continue;

    //Process BUDGET factiii
    if (factiii && factiii.requirements.includes(FactiiiRequirement.BUDGET)) {
      const existingData = factiii?.data;

      //everything needs to use postFactiii.data, no such thing as currency
      // const currencyToUpdate = postFactiii.currency;

      // Parse the existing data and update the value for the specific currency
      let updatedData: string | undefined = "";
      if (!existingData) {
        // If existing data is null or undefined, set the updated data as is
        // updatedData = `${postFactiii.budget} ${currencyToUpdate}`;
        // } else if (!existingData.includes(currencyToUpdate)) {
        // If currency is not present in existing data, append it
        // updatedData = `${existingData}, ${postFactiii.budget} ${currencyToUpdate}`;
      } else {
        updatedData = existingData
          ?.split(",")
          .map((item) => {
            const [value, currency] = item.trim().split(" ");
            // if (currency === currencyToUpdate) {
            // Add the new budget value to the existing value
            // const newValue = parseFloat(value) + postFactiii.budget;
            // return `${newValue} ${currency}`;
            // }
            return item.trim();
          })
          .join(", ");
      }
      //Update the data in the database
      await prisma.factiii.update({
        where: {
          id: factiii?.id,
        },
        data: {
          data: updatedData,
        },
      });
    }

    //Process NO_POST_DUPLICATES factiii
    if (factiii?.requirements.includes("NO_POST_DUPLICATES")) {
      const checkPost = await prisma.postFactiii.findFirst({
        where: {
          id: post.id,
          factiiiId: factiii.id,
        },
      });
      if (checkPost) {
        //duplicate postFactiii found, skip
        continue;
      }
    }

    // if factiii is NSFW or Politics, check if it has already been tagged and report it if not
    if (
      factiii &&
      (factiii.name.toLocaleLowerCase() === "NSFW".toLocaleLowerCase() ||
        factiii.name.toLocaleLowerCase() === "Politics".toLocaleLowerCase())
    ) {
      const tagsFound = await prisma.postFactiii.findFirst({
        where: {
          id: post.id,
          factiiiId: postFactiii.factiiiId,
        },
      });

      if (!tagsFound) {
        await submitReport(factiii, post.id, userId);
      }
    }

    const upsertedPostFactiii = await prisma.postFactiii.upsert({
      where: {
        postId_factiiiId_userId: {
          postId: post.id,
          factiiiId: factiii.id,
          userId,
        },
      },
      update: {
        data: postFactiii.data,
        anonymous: postFactiii.anonymous,
        uploads: {
          set: [], // This disconnects all currently connected uploads
          connect: postFactiii.uploads?.map((upload) => ({ id: upload.id })),
        },
        // status: postFactiii.status,
      },
      create: {
        postId: post.id,
        factiiiId: factiii.id,
        userId,
        data: postFactiii.data,
        anonymous: postFactiii.anonymous,
        uploads: {
          connect: postFactiii.uploads?.map((upload) => ({ id: upload.id })),
        },
        // status: postFactiii.status,
      },
      select: {
        id: true,
      },
    });

    // if postFactiii has spaceTimes, handle them separately
    if (postFactiii.spaceTimes && postFactiii.spaceTimes.length > 0) {
      // delete existing spaceTimes (assuming you want to replace them completely)
      await prisma.spaceTime.deleteMany({
        where: { postFactiiiId: upsertedPostFactiii.id },
      });

      // create new spaceTimes
      for (const spaceTime of postFactiii.spaceTimes) {
        await prisma.spaceTime.create({
          data: {
            ...spaceTime,
            postFactiiiId: upsertedPostFactiii.id,
          },
        });
      }
    }
    //Make post private if it has DISAPPEARING_DATA and data is sent
    if (factiii?.requirements.includes("DISAPPEARING_DATA")) {
      await prisma.post.update({
        where: {
          id: post.id,
        },
        data: {
          ...(userId === post.userId
            ? {
                //Post.userId and user tagging are the same
                ...(postFactiii.data
                  ? {
                      //If data, remove anonymous
                      anonymous: false,
                    }
                  : {
                      //If no data, keep anonymous
                      anonymous: true,
                    }),
              }
            : {}),
          status: postFactiii.data ? "PRIVATE" : "PUBLISHED",
        },
      });
    }
  }

  if (removeFactiiiIds) {
    for (const factiiiId of removeFactiiiIds) {
      await prisma.postFactiii.delete({
        where: {
          postId_factiiiId_userId: {
            postId: post.id,
            factiiiId,
            userId,
          },
        },
      });
    }
  }
};
