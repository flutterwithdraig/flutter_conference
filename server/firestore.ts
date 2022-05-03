import * as admin from 'firebase-admin'

import serviceAccount from './service_account.json'

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
    storageBucket: 'gs://global-conference.appspot.com'
})

const firestore = admin.firestore()
const storage = admin.storage()
const fbAuth = admin.auth();
export { firestore as db, fbAuth, storage, admin }