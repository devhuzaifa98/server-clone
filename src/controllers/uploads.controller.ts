import { Request, Response } from "express";
import { fromBuffer } from "file-type";
import { v4 as uuid } from "uuid";
import prisma from "../clients/prisma";
import { getS3ObjectURL, uploadMedia } from "../clients/s3";
import AppError from "../utilities/AppError";

export const upload = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  // accepts base64 and saves to S3
  const base64 = req.body.source;
  const name = req.body.name;

  const mediaCountInLast5Min = await prisma.upload.count({
    where: {
      userId,
      createdAt: {
        gt: new Date(new Date().setMinutes(new Date().getMinutes() - 5)),
      },
    },
  });
  ``;

  if (mediaCountInLast5Min > 5)
    throw new AppError("You can only upload 5 media items every 5 minutes.");

  const buf = Buffer.from(base64.replace(/^data:[^;]+;base64,/, ""), "base64");
  const fileType = await fromBuffer(buf);

  if (
    !(
      fileType?.mime.includes("image") ||
      fileType?.mime.includes("video") ||
      fileType?.mime.includes("pdf") ||
      fileType?.ext === "docx" ||
      fileType?.ext === "xlsx" ||
      fileType?.ext === "pptx"
    )
  ) {
    throw new AppError(
      "The type of file you provided is unsupported. Please provide base64 encoded.",
    );
  }

  const result = await uploadMedia(buf, `${userId}/${uuid()}.${fileType?.ext}`);

  const upload = await prisma.upload.create({
    data: {
      key: result.Key,
      userId: userId,
      type: fileType.mime.includes("image")
        ? "IMAGE"
        : fileType.mime.includes("video")
          ? "VIDEO"
          : "DOCUMENT",
      name: name ?? null,
      size: buf.byteLength ?? 0,
    },
  });

  return res.send({
    url: result.Location,
    key: result.Key,
    id: upload.id,
    type: upload.type,
  });
};

export const get = async (req: Request, res: Response) => {
  const userId: number = req.body.auth?.userId ?? 0;
  const { id } = req.params;

  const upload = await prisma.upload.findFirst({
    where: {
      id: id,
      userId: userId,
    },
  });

  if (!upload) throw new AppError("No such upload found.");

  return res.send(upload);
};

export const getUserUploads = async (req: Request, res: Response) => {
  const { username } = req.query as { username: string };

  const user = await prisma.user.findFirst({
    where: {
      username,
    },
    select: {
      id: true,
      username: true,
    },
  });

  const userUploads = await prisma.upload.findMany({
    where: {
      userId: user?.id,
      OR: [
        { userAvatars: { some: { id: user?.id } } },
        { userBanners: { some: { id: user?.id } } },
        { posts: { some: { userId: user?.id } } },
        { reports: { some: { userId: user?.id } } },
        { spaceAvatars: { some: { avatar: { userId: user?.id } } } },
        { spaceBanners: { some: { banner: { userId: user?.id } } } },
        { feedback: { some: { media: { userId: user?.id } } } },
        { product: { images: { some: { userId: user?.id } } } },
        { factiiiAvatars: { some: { avatar: { userId: user?.id } } } },
        { factiiiBanners: { some: { banner: { userId: user?.id } } } },
      ],
    },
    take: 10,
    select: {
      id: true,
      name: true,
      size: true,
      key: true,
      type: true,
    },
  });

  const orphanedUploads = await prisma.upload.findMany({
    where: {
      userId: user?.id,
      NOT: {
        OR: [
          { userAvatars: { some: { id: user?.id } } },
          { userBanners: { some: { id: user?.id } } },
          { posts: { some: { userId: user?.id } } },
          { reports: { some: { userId: user?.id } } },
          { spaceAvatars: { some: { avatar: { userId: user?.id } } } },
          { spaceBanners: { some: { banner: { userId: user?.id } } } },
          { feedback: { some: { media: { userId: user?.id } } } },
          { product: { images: { some: { userId: user?.id } } } },
          { factiiiAvatars: { some: { avatar: { userId: user?.id } } } },
          { factiiiBanners: { some: { banner: { userId: user?.id } } } },
        ],
      },
    },
    select: {
      id: true,
      name: true,
      size: true,
      key: true,
      type: true,
    },
    take: 100,
  });

  return res.send({
    username: user?.username,
    userUploads: userUploads.map((x) => ({
      id: x.id,
      url: getS3ObjectURL(x.key),
      type: x.type,
      name: x.name,
      size: x.size,
      key: x.key,
    })),
    orphanedUploads: orphanedUploads.map((x) => ({
      id: x.id,
      url: getS3ObjectURL(x.key),
      type: x.type,
      name: x.name,
      size: x.size,
      key: x.key,
    })),
  });
};
