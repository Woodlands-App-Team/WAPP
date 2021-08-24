import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/pages/song_req_page/song_req_page.dart';
import 'package:wapp/pages/song_upvote_page/song_upvote_page_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wapp/pages/song_upvote_page/song_upvote_tile.dart';

class SongUpvotePage extends StatefulWidget {
  const SongUpvotePage({Key? key}) : super(key: key);

  @override
  _SongUpvotePageState createState() => _SongUpvotePageState();
}

class _SongUpvotePageState extends State<SongUpvotePage> {
  final FirebaseAuth _user = FirebaseAuth.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  upvoteSong(song) async {
    print("Before function");
    HttpsCallable upvoteSong = functions.httpsCallable('upvoteSong');
    await upvoteSong
        .call(<String, dynamic>{"uid": _user.currentUser!.uid, "song": song});
    print("After function");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        elevation: 10,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SongReqPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: white,
            ),
            width: 230,
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_rounded,
                  size: 30,
                  color: dark_blue,
                ),
                Text("Request Song",
                    style: GoogleFonts.poppins(
                        color: grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: songUpvotePageAppBar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('song-requests')
                  .orderBy("date", descending: true)
                  .where("approved", isEqualTo: true)
                  .limit(10)
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      if (doc['upvotedUsers']
                          .contains(_user.currentUser!.uid)) {
                        return SongUpvoteTile(doc["name"], doc["artist"],
                            doc["imgURL"], doc["upvotes"], true);
                      } else {
                        return InkWell(
                          onTap: () {
                            upvoteSong(doc.id);
                          },
                          child: SongUpvoteTile(doc["name"], doc["artist"],
                              doc["imgURL"], doc["upvotes"], false),
                        );
                      }
                    },
                  );
                }
              })),
    );
  }
}
