import { Router } from 'express';
import { Stripe } from 'stripe';
import { db, fbAuth } from '../firestore';


const router = Router();

const products = [
{code: 'event1', price: 5500 },
{code: 'cap1', price: 1099 },
{code: 'tshirt1', price: 2550 },
];

router.post('/payment-sheet', async (req, res) => {
    const uid = req.uid;
    if(uid == undefined){
        return res.status(401);
    }
    let cart = JSON.parse(req.body.cart);
    let total = 0;

    const items: any[] = [];

    cart.forEach((item: any) => {
        const code = item.code;
        const qty = item.qty;
        if(qty < 1){
            return res.status(401);
        }
        total += (products.find(p => p.code == code)?.price ?? 0) * qty;
        items.push(item);
    });

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

    const ephemeralKey = await stripe.ephemeralKeys.create({
        customer: stripeCustomerId
    }, {apiVersion: '2020-08-27'});
    
    const paymentIntent = await stripe.paymentIntents.create({
        amount: total,
        currency: 'gbp',
        customer: stripeCustomerId,
        payment_method_types: ['card'],
    })

    db.collection('orders').doc(paymentIntent.id).set({
        uid,
        items,
        status: 'unpaid'
    })

    res.json({
        paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: stripeCustomerId,
    })

});

export { router as StripeController}