import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();

export const processPayementItems = functions.firestore
    .document("orders/{orderId}").onUpdate((change, context) => {

        const newData = change.after.data();
        const oldData = change.before.data();

        if(newData['status'] == "paid" && oldData['status'] == "unpaid"){
            const items: [{code: string, qty: number}] = newData["items"];
            const uid = newData["uid"];

            items.forEach((item) => {
                const code = item['code'];
                if(code.startsWith("event")){
                    db.collection("users").doc(uid).update({
                        paidEvents: admin.firestore.FieldValue.arrayUnion(code)
                    });
                }
            });
        }

    });