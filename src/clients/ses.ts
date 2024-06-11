import { SESClient, SendEmailCommand } from "@aws-sdk/client-ses";
import log from "../helpers/log";

export const sesClient = new SESClient({
  region: process.env.AWS_SES_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID as string,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY as string,
  },
});

const HTML_BOILERPLATE = (content: string) => `
    <div style="max-width: 600px; margin: 0 auto;">
        ${content}
    </div>
`;

const sendEmail = async (to: string, subject: string, html: string) => {
  if (!/\S+@\S+\.\S+/.test(to) || !subject || !html) return false;

  try {
    const command = new SendEmailCommand({
      Destination: {
        ToAddresses: [to],
      },
      Message: {
        Body: {
          Html: {
            Charset: "UTF-8",
            Data: HTML_BOILERPLATE(html),
          },
        },
        Subject: {
          Charset: "UTF-8",
          Data: subject,
        },
      },
      Source: process.env.AWS_SES_FROM_EMAIL_ADDRESS,
    });

    const email = await sesClient.send(command);
    log(
      `[${new Date().toLocaleString()}] EMAIL SENT ${to} (ID: ${email.MessageId})`,
    );
    if (email.MessageId) return true;
  } catch (error: any) {
    log(`[${new Date().toLocaleString()}] AWS SES ERROR: ${error.message}`);
    return false;
  }
};

export const sendPasswordResetEmail = async (email: string, token: string) => {
  return await sendEmail(
    email,
    "Reset your Facti password",
    `
        <h1>You have requested a password reset</h1>
        <br />
        <p>Click the "Reset Password" button below to reset your password. If the button does not work you can copy and paste the link below it. If you do not request this then please ignore this email.</p>
        <br />
        <button>
            <a href="${process.env.CLIENT_APP_URL}/reset-password/${token}">
                Reset password
            </a>
        </button>
        <br />
        ${process.env.CLIENT_APP_URL}/reset-password/${token}
    `,
  );
};

export const sendEmailVerificationEmail = async (
  email: string,
  otp: string,
) => {
  return await sendEmail(
    email,
    "Email Verification",
    `
        <h1>Verify Your Email</h1>
        <br />
        <p>Click the "Verify Email" button below to verify your email. If the button does not work you can copy and paste the link below it. If you do not request this then please ignore this email.</p>
        <br />
        <button>
            <a href="${process.env.CLIENT_APP_URL}/verify-email/${otp}">
                Verify Email
            </a>
        </button>
        <br />
        <br />
        <br />
        ${process.env.CLIENT_APP_URL}/verify-email/${otp}
    `,
  );
};

export const sendUserDeactivationEmail = async (
  email: string,
  username: string,
) => {
  return await sendEmail(
    email,
    "We're sad to see you go",
    `
        <h1>We've deactivated your account</h1>
        <br />
        <p>@${username}, we're sorry to see you go.</p>
    `,
  );
};

export const sendDSAR = async (
  name: string,
  email: string,
  selectedAs: string,
  requestUnder: string,
  selectedTo: string,
  details: string,
  userId: number,
) => {
  return await sendEmail(
    "support@factiii.com",
    `DSAR Report for ${name}`,
    `
        <h1>Here is the DSAR report</h1>
        <br />
        <div>Name: ${name}</div>
        <div>UserId: ${userId}</div>
        <br />
        <div>email: ${email}</div>
        <br />
        <div>selectedAs: ${selectedAs}</div>
        <br />
        <div>requestUnder: ${requestUnder}</div>
        <br />
        <div>selectedTo: ${selectedTo}</div>
        <br />
        <div>Details: ${details}</div>
    `,
  );
};

export const sendReferralEmail = async (
  email: string,
  token: string,
  name: string,
) => {
  return await sendEmail(
    email,
    `${name} has invited you to join Facti`,
    `
        <h1>${name} has invited you to join Facti.</h1>
        <br />
        <p>Click the "Join Now" button below to accept the request and sign up for Facti. If the button does not work you can copy and paste the link below it.</p>
        <button>
            <a href="${process.env.CLIENT_APP_URL}/join?ref=${token}">
                Reset password
            </a>
        </button>
        <br />
        ${process.env.CLIENT_APP_URL}/reset-password/join?ref=${token}
    `,
  );
};

export const sendOTPLoginEmail = async (email: string, code: number) => {
  return await sendEmail(
    email,
    `Your Factiii Login Code`,
    `
        <p>Enter the code below to login to your account to your Factiii account.</p>
        <h1>${code}</h1>
        <br />
        <p>If you didn't request this code, please change your password right away and review your sessions.</p>
    `,
  );
};
