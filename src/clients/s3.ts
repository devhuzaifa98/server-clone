import dotenv from "dotenv";
import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3";
import { fromBuffer } from "file-type";
import AppError from "../utilities/AppError";

dotenv.config();

export const s3 = new S3Client({
  region: process.env.AWS_S3_REGION as string,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID as string,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY as string,
  },
});
export const S3_REGION = process.env.AWS_S3_REGION;
export const S3_BUCKET = process.env.AWS_S3_BUCKET;

export const getS3ObjectURL = (key: string | undefined) => {
  if (!key) return null;
  //Load from link given
  if (key.includes("http://") || key.includes("https://")) {
    return key;
    //Load from local public server on NextJS front end
  } else if (key.charAt(0) == "/") {
    return key;
    //all others load from s3
  } else {
    const prefix = process.env.AWS_S3_OBJECTS_URL_PREFIX;
    return `${prefix}/${key}`;
  }
};

export const uploadMedia = async (media: Buffer, key: string) => {
  const fileType = await fromBuffer(media);

  const params = {
    Bucket: process.env.AWS_S3_BUCKET as string,
    Key: key,
    ACL: "public-read",
    ContentType: fileType?.mime,
    Body: media,
  };

  await s3.send(new PutObjectCommand(params));

  return {
    Key: key,
    Location: getS3ObjectURL(key),
  };
};
