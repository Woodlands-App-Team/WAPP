const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

exports.initNewUser = functions.auth.user().onCreate(user => {
    return admin.firestore().collection('users').doc(user.uid).set({
        email: user.email,
        push_notif_announcement: [],
        push_notif_event: false,
        last_song_req: null,
        upvoted_songs: [],
    })
});

exports.deleteUser = functions.auth.user().onDelete(user => {
    const doc = admin.firestore().collection('users').doc(user.uid);
    return doc.delete();
});

exports.requestSong = functions.https.onCall((data, context) => {
    if(!context.auth){
        throw new functions.https.HttpsError('unauthenticated', 'only authenticated users can add requests')
    }
    admin.firestore().collection('song-requests').add({
        songURL: data.songURL,
        upvotes: 0,
        approved: false,
        date: data.date,

    })
    admin.firestore().collection('users').doc(data.uid).update({
        last_song_req: data.date,
    })
    return data.songName;
}); 

const db = admin.firestore(); 
const fcm = admin.messaging(); 

exports.sendToTopic = functions.firestore.document('announcements/{announcementID}').onCreate(async (snapshot, context) => {
    const annoucementInfo = snapshot.data(); 
    const payload = {
        notification: {
            title: "New Annoucement",
            body: annoucementInfo.description, 
            sound: 'default', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK',  
        }, 
        data: {
            message: "Test Data", 
        }
    }; 
    return admin.messaging().sendToTopic("WAA", payload).then(response => {
        console.log("Success"); 
    }).catch(error => {
        console.log("Failed"); 
    }); 
});