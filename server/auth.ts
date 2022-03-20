import { NextFunction, Request, Response } from 'express';
import { admin } from './firestore';

const adminKey = 'letmein'

const authMiddleWare = async (req: Request, res: Response, next: NextFunction) => {

    try {
    const token = req.headers?.authorization ?? ''
    const decodedToken = await admin.auth().verifyIdToken(token.replace('Token ', ''));
    req.uid = decodedToken.uid
    } catch (e) {
        req.uid = null
    }

    req.admin = req.query.key === adminKey || req.body.key === adminKey
    next()
}

const requireAuth = (req: Request, res: Response, next: NextFunction) => {
    if(req.uid || req.admin) {
        next()
    } else {
        return res.status(401).send('Unauthorised')
    }
}

const requireAdmin = (req: Request, res: Response, next: NextFunction) => {
    if(req.admin) {
        next()
    } else {
        return res.status(401).send('Unauthorised - admin required')
    }
}

const requireSelf = (req: Request, res: Response, next: NextFunction) => { 
    if(req.uid === req.params.id || req.admin){
        next()
    } else {
        return res.status(401).send('Unauthorised - You can only edit yourself')
    }
}

export {authMiddleWare, requireAuth, requireAdmin, requireSelf}