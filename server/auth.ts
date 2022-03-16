import { NextFunction, Request, Response } from 'express';
import { admin } from './firestore';

const authMiddleWare = async (req: Request, res: Response, next: NextFunction) => {

    try {
    const token = req.headers?.authorization ?? ''
    const decodedToken = await admin.auth().verifyIdToken(token.replace('Token ', ''));
    req.uid = decodedToken.uid
    } catch (e) {
        req.uid = null
        return res.status(401).send('Unauthorized')
    }


    next()
}

export {authMiddleWare}