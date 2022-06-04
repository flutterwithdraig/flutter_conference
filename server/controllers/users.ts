import { Router } from 'express';
import fileUpload from 'express-fileupload';
import { requireAdmin, requireSelf } from '../auth';
import { admin, db, storage } from '../firestore';
import { v4 } from 'uuid';
import { RtcTokenBuilder, RtcRole } from 'agora-access-token';


const router = Router()

// C R U D 

router.post('/', requireAdmin, async (req, res) => {

    const email = req.body.email
    const password = req.body.password
    const displayName = req.body.display_name
    const profile = req.body.profile

    if (!email || !password || !displayName || !profile) {
        return res.status(422).json({ err: 'Missing data' })
    }

    // Setup user with firebase auth
    const user = await admin.auth().createUser({
        email,
        password,
        displayName,
    })

    // Store user details in the firestore users collection
    await db.collection('users').doc(user.uid).create({
        name: displayName,
        profile,
        created: admin.firestore.FieldValue.serverTimestamp(),
        updated: admin.firestore.FieldValue.serverTimestamp(),
    })

    res.json({ msg: 'User created', uid: user.uid })
})


router.get('/', async (req, res) => {

    console.log(req.uid)

    const documentData = await db.collection('users').get()
    const result = documentData.docs.map((d) => ({
        id: d.id,
        ...d.data()
    }))
    res.json(result);
})

router.patch('/:id', requireSelf, async (req, res) => {
    console.log(req.body);
    const name = req.body.name;
    const profile = req.body.profile;

    if (name.length < 5) {
        return res.json({ code: 400 });
    }

    try {
        await db.collection('users').doc(req.params.id).set({
            name,
            profile
        }, { merge: true });
        return res.json({ code: 200 });
    } catch {
        return res.json({ code: 500 });
    }

})

router.get('/:id/paidevents', requireSelf, async (req, res) => {
    const uid = req.uid!
    const data = await db.collection('users').doc(uid).get();
    const events = data.get('paidEvents') ?? [];
    return res.json({ events })
})

router.get('/:id/livetoken/:eventId', async (req, res) => {
    const uid = req.uid!
    const eventId = req.params.eventId;

    const eventDoc = await db.collection('events').doc(eventId).get();
    if(!eventDoc.exists){
        return res.status(400);
    }

    const stream = eventDoc.get('streamedEvent') ?? false;
    if(!stream){
        return res.status(400);
    }

    const purchaseCode = eventDoc.get('purchaseCode') as string;
    if(purchaseCode != undefined){
        const userDoc = await db.collection('users').doc(uid).get();
        const paidEvents: string[] = userDoc.get('paidEvents') ?? [];
        if(!paidEvents.includes(purchaseCode)){
            return res.status(400);
        }
    }

    const expireTime = 3600 * 2; // 2 hours
    const currentTime = Math.floor(Date.now() / 1000);
    const privExpireTime = currentTime + expireTime;

    const token = RtcTokenBuilder.buildTokenWithUid(
        process.env.AGORA_APP_ID!,
        process.env.AGORA_APP_CERTIFICATE!,
        eventId,
        0,
        RtcRole.SUBSCRIBER,
        privExpireTime
    );

   
    return res.json({token})


})

router.get('/:id', async (req, res) => {
    const documentSnap = await db.collection('users').doc(req.params.id).get()

    if (!documentSnap.exists) {
        return res.status(404).json({ error: 'User not found' })
    }

    res.json({
        uid: documentSnap.id,
        ...documentSnap.data()
    })
})


router.post('/:id/image', requireSelf, async (req, res) => {

    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).json({ error: 'No file uploaded' })
    }

    const uid = req.uid;
    if (uid === null) return res.status(400).json({ error: 'No UID' })
    const uuid = v4()
    const path = `${uuid}.jpg`

    let file = req.files.image as fileUpload.UploadedFile
    const destination = storage.bucket().file(path);
    destination.save(file.data, {
        metadata: {
            metadata: {
                firebaseStorageDownloadTokens: uuid
            }
        }
    }, async (err) => {
        if (err) {
            console.log(err)
        }
        const imageUrl = `https://firebasestorage.googleapis.com/v0/b/global-conference.appspot.com/o/${path}?alt=media&token=${uuid}`
        await db.collection('users').doc(uid).update({
            imageUrl
        });
        return res.json({ imageUrl });
    })

})

export { router as UsersController }