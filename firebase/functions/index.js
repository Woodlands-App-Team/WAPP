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

    })
    admin.firestore().collection('users').doc(data.uid).set({
        last_song_req: data.date,
    })
})