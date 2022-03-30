import { Router } from 'express';
import fileUpload from 'express-fileupload';
import { requireAdmin, requireSelf } from '../auth';
import { admin, db, storage } from '../firestore';
import { v4 } from 'uuid';


const router = Router()

// C R U D 

router.post('/', requireAdmin, async (req, res) => {

    const email = req.body.email
    const password = req.body.password
    const displayName = req.body.display_name
    const profile = req.body.profile

    if(!email || !password || !displayName || !profile){
        return res.status(422).json({err: 'Missing data'})
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

    res.json({msg: 'User created', uid: user.uid})
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
    res.send('OK')
})

router.get('/:id', async (req, res) => {
    const documentSnap = await db.collection('users').doc(req.params.id).get()

    if(!documentSnap.exists){
        return res.status(404).json({error: 'User not found'})
    }

    res.json({
        uid: documentSnap.id,
        ...documentSnap.data()
    })
})


router.post('/:id/image', requireSelf, async (req, res) => {

    if(!req.files || Object.keys(req.files).length === 0){
        return res.status(400).json({error: 'No file uploaded'})
    }

    const uid = req.uid;
    if(uid === null) return res.status(400).json({error: 'No UID'})
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
        if(err) {
            console.log(err)
        }
        const imageUrl = `https://firebasestorage.googleapis.com/v0/b/global-conference.appspot.com/o/${path}?alt=media&token=${uuid}`
        await db.collection('users').doc(uid).update({
            imageUrl
        });
        return res.json({imageUrl});
    })

})

export { router as UsersController}