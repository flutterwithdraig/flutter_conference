import { Router } from 'express';
import { Stripe } from 'stripe';
import { db, fbAuth } from '../firestore';


const router = Router();

router.post('/payment-sheet', async (req, res) => {
    const uid = req.uid;
    if(uid == undefined){
        return res.status(401);
    }

    const secret_key = process.env.STRIPE_SECRET_KEY;
    const stripe = new Stripe(secret_key as string, {
        apiVersion: '2020-08-27',
        typescript: true,
    });

    // is this user a current stripe user?
    const userDocData = await db.collection('stripe-users').doc(uid).get();

    let stripeCustomerId;
    if(userDocData.exists){
        stripeCustomerId = userDocData.get('stripeid');
    } else {
        const fbUser = await fbAuth.getUser(uid);
        const result  = await stripe.customers.create({
            email: fbUser.email
        });
        stripeCustomerId = result.id;
        await db.collection('stripe-users').doc(uid).create({stripeid: stripeCustomerId});
    }

    const ephmeralKey = await stripe.ephemeralKeys.create({
        customer: stripeCustomerId
    }, {apiVersion: '2020-08-27'});
    
    const paymentIntent = await stripe.paymentIntents.create({
        amount: 8700,
        currency: 'gbp',
        customer: stripeCustomerId,
        payment_method_types: ['card'],
    })

    res.json({
        paymentIntent: paymentIntent.client_secret,
        ephmeralKey: ephmeralKey.secret,
        customer: stripeCustomerId,
    })

});

export { router as StripeController}