// import { Request, Response, NextFunction } from 'express';
// import jwt from 'jsonwebtoken';
// import prisma from '../clients/prisma';

// const sessionHandler = () => {
//     return async (req: Request, res: Response, next: NextFunction) => {
//         const authHeader = req.headers['authorization'];
//         const accessToken = authHeader?.split(' ')[1];

//         try {
//             const isAuthenticationURL = ['/register', '/login'].includes(req.url);

//             if (isAuthenticationURL) {
//                 jwt.verify(accessToken as string, process.env.ACCESS_TOKEN_SECRET as string, async (_err, result) => {
//                     if (result) {
//                         const { userId, refresher: refreshToken, browserName } = result as jwt.JwtPayload;

//                         if (refreshToken) {
//                             const token = await prisma.session.findFirst({
//                                 where: {
//                                     refreshToken: refreshToken,
//                                     revokedAt: null,
//                                     browserName: browserName
//                                 },
//                                 select: {
//                                     userId: true,
//                                     refreshToken: true,
//                                     browserName: true,
//                                 },
//                             });

//                             if (token) {
//                                 return res.status(409).json({ error: true, message: 'Already signed in' });
//                             }
//                         }

//                         req.body.auth = result;
//                     }
//                     next();
//                 });
//             }
//         } catch (error) {
//             res.status(500).json({ error: true, message: 'Something went wrong' });
//         }
//     };
// };

// export default sessionHandler;
