import * as admin from 'firebase-admin'

import serviceAccount from './service_account.json'

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount)
})

const firestore = admin.firestore()
export { firestore as db, admin }