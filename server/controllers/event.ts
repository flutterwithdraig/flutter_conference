import { Router } from 'express';
import { db } from '../firestore';


const router = Router()

// C R U D 

router.get('/', async (req, res) => {

    const documentData = await db.collection('events').get()
    const result = documentData.docs.map((d) => ({
        id: d.id,
        ...d.data()
    }))
    res.json(result);
})


router.get('/:id', async (req, res) => {
    const documentSnap = await db.collection('events').doc(req.params.id).get()

    if(!documentSnap.exists){
        return res.status(404).json({error: 'Event not found'})
    }

    res.json({
        id: documentSnap.id,
        ...documentSnap.data()
    })
})

export { router as EventController}