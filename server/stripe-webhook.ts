import { Request, Response } from 'express';
import Stripe from 'stripe';
import { db } from './firestore';

export function stripeWebhook(req: Request, res: Response){

    let event: Stripe.Event

    const key = process.env.STRIPE_SECRET_KEY as string;
    const signature = process.env.STRIPE_SIGNING_SECRET as string;

    const stripe = new Stripe(key, {
        apiVersion: '2020-08-27',
        typescript: true
    });

    const signed_header = req.headers['stripe-signature'] || [];

    try {
    event = stripe.webhooks.constructEvent(
        req.body,
        signed_header, 
        signature
    );
    } catch (err) {
        console.log('Webhook signature error');
        return res.sendStatus(400);
    }

    const data: Stripe.Event.Data = event.data;
    const eventType: string = event.type;
    
    if(eventType == 'payment_intent.succeeded'){
        const pi: Stripe.PaymentIntent = data.object as Stripe.PaymentIntent;
        db.collection('orders').doc(pi.id).update({status: 'paid'});
    }
    return res.sendStatus(200);
}