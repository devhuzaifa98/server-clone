import { Request, Response } from "express";
import prisma from "../clients/prisma";
import {
  generateFactiiiOGImage,
  generatePostOGImage,
  generateProfileOGImage,
  generateSpaceOGImage,
} from "../helpers/generateOpenGraphImages";
import { getS3ObjectURL, uploadMedia } from "../clients/s3";
import axios from "axios";

export const postOpenGraphImage = async (req: Request, res: Response) => {
  const { postId } = req.params;

  const check = await prisma.post.findFirst({
    where: {
      uuid: postId,
    },
    select: {
      id: true,
      userId: true,
    },
  });

  if (!check) throw new Error("Invalid post ID provided");

  const mediaCheck = await prisma.upload.findFirst({
    where: {
      key: `opengraph/images/posts/${postId}`,
    },
  });

  if (!mediaCheck) {
    const buffer = (await generatePostOGImage(postId)) as string;
    const buf = Buffer.from(
      buffer?.replace(/^data:\w+\/\w+;base64,/, ""),
      "base64",
    );
    const media = await uploadMedia(buf, `opengraph/images/posts/${postId}`);
    await prisma.upload.create({
      data: {
        userId: check.userId,
        key: media.Key,
        type: "IMAGE",
      },
    });

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  } else {
    const url = getS3ObjectURL(mediaCheck.key);
    const { data } = await axios.get(url as string, {
      responseType: "arraybuffer",
    });
    const buffer = Buffer.from(data, "utf-8");

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  }
};

export const profileOpenGraphImage = async (req: Request, res: Response) => {
  const { username } = req.params;

  const check = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
    },
  });

  if (!check) throw new Error("Invalid post ID provided");

  const mediaCheck = await prisma.upload.findFirst({
    where: {
      key: `opengraph/images/profile/${username}`,
    },
  });

  if (!mediaCheck) {
    const buffer = (await generateProfileOGImage(username)) as string;
    const buf = Buffer.from(
      buffer?.replace(/^data:\w+\/\w+;base64,/, ""),
      "base64",
    );
    const media = await uploadMedia(
      buf,
      `opengraph/images/profile/${username}`,
    );
    await prisma.upload.create({
      data: {
        userId: check.id,
        key: media.Key,
        type: "IMAGE",
      },
    });

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  } else {
    const url = getS3ObjectURL(mediaCheck.key);
    const { data } = await axios.get(url as string, {
      responseType: "arraybuffer",
    });
    const buffer = Buffer.from(data, "utf-8");

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  }
};

export const spaceOpenGraphImage = async (req: Request, res: Response) => {
  const { slug } = req.params;

  const check = await prisma.space.findFirst({
    where: {
      slug,
    },
    select: {
      id: true,
      members: {
        where: {
          OR: [
            {
              roles: {
                has: "OWNER",
              },
            },
            {
              roles: {
                has: "MODERATOR",
              },
            },
          ],
        },
      },
    },
  });

  if (!check) throw new Error("Invalid post ID provided");

  const mediaCheck = await prisma.upload.findFirst({
    where: {
      key: `opengraph/images/space/${slug}`,
    },
  });

  if (!mediaCheck) {
    const buffer = (await generateSpaceOGImage(slug)) as string;
    const buf = Buffer.from(
      buffer?.replace(/^data:\w+\/\w+;base64,/, ""),
      "base64",
    );
    const media = await uploadMedia(buf, `opengraph/images/space/${slug}`);
    await prisma.upload.create({
      data: {
        userId: check.members[0].userId,
        key: media.Key,
        type: "IMAGE",
      },
    });

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  } else {
    const url = getS3ObjectURL(mediaCheck.key);
    const { data } = await axios.get(url as string, {
      responseType: "arraybuffer",
    });
    const buffer = Buffer.from(data, "utf-8");

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  }
};

export const factiiiOpenGraphImage = async (req: Request, res: Response) => {
  const { slug } = req.params;

  const check = await prisma.factiii.findFirst({
    where: {
      slug,
    },
    select: {
      id: true,
    },
  });

  if (!check) throw new Error("Invalid post ID provided");

  const mediaCheck = await prisma.upload.findFirst({
    where: {
      key: `opengraph/images/factiii/${slug}`,
    },
  });

  if (!mediaCheck) {
    const buffer = (await generateFactiiiOGImage(slug)) as string;
    const buf = Buffer.from(
      buffer?.replace(/^data:\w+\/\w+;base64,/, ""),
      "base64",
    );
    const media = await uploadMedia(buf, `opengraph/images/factiii/${slug}`);
    await prisma.upload.create({
      data: {
        userId: check.id,
        key: media.Key,
        type: "IMAGE",
      },
    });

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  } else {
    const url = getS3ObjectURL(mediaCheck.key);
    const { data } = await axios.get(url as string, {
      responseType: "arraybuffer",
    });
    const buffer = Buffer.from(data, "utf-8");

    res.set("Content-Type", "image/png");
    res.set("Content-Disposition", "inline; filename=opengraph-thumb.png");
    res.send(new Buffer(buffer as any, "base64"));
  }
};
