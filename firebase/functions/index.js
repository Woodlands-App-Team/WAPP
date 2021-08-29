const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

exports.initNewUser = functions.auth.user().onCreate(user => {
    return admin.firestore().collection('users').doc(user.uid).set({
        email: user.email,
        push_notif_announcement: [],
        push_notif_event: false,
        last_song_req: null,
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
        name: data.name,
        artist: data.artist,
        imgURL: data.imgURL,
        upvotes: 0,
        approved: false,
        date: data.date,
        upvotedUsers: [],

    })
    admin.firestore().collection('users').doc(data.uid).update({
        last_song_req: data.date,
    })
    return data.name;
}); 

const db = admin.firestore(); 
const fcm = admin.messaging(); 

exports.sendToTopic = functions.firestore.document('announcements/{announcementID}').onCreate(async (snapshot, context) => {
    const annoucementInfo = snapshot.data(); 
    const payload = {
        notification: {
            title: annoucementInfo.title,
            body: annoucementInfo.description, 
            sound: 'default', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK',  
        }, 
    }; 
    // return admin.messaging().sendToTopic(annoucementInfo.title.replace(/ /g, ''), payload); 
    return admin.messaging().sendToTopic("SAC", payload); 
});

exports.upvoteSong = functions.https.onCall((data, context) => {
    if(!context.auth){
        throw new functions.https.HttpsError('unauthenticated', 'only authenticated users can add requests')
    }

    return admin.firestore().collection('song-requests').doc(data.song).update({
        upvotedUsers: admin.firestore.FieldValue.arrayUnion(data.uid),
        upvotes: admin.firestore.FieldValue.increment(1),
    })
});