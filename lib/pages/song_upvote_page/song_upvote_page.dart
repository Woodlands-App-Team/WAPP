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

  SongUpvoteTile tile(doc, isUpvoted) {
    return SongUpvoteTile(
        doc["name"], doc["artist"], doc["imgURL"], doc["upvotes"], isUpvoted);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F5F2),
      floatingActionButton: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                elevation: 10,
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
                      Text("Loading...",
                          style: GoogleFonts.poppins(
                              color: grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              );
            } else {
              if (snapshot.data!['last_song_req'] == null ||
                  snapshot.data!['last_song_req'] == "") {
                return Card(
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
                          SizedBox(
                            width: 10,
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
                );
              }
              if (DateTime.parse((snapshot.data!['last_song_req'].toString()))
                  .isBefore(DateTime.now().subtract(Duration(days: 30)))) {
                return Card(
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
                            size: 27,
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
                );
              } else {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
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
                            Icons.check_circle_outline_rounded,
                            size: 30,
                            color: dark_blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Song Requested",
                              style: GoogleFonts.poppins(
                                  color: grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: songUpvotePageAppBar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
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
                      if (index == snapshot.data!.docs.length - 1 ||
                          index == 0) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            index == 0 ? 10 : 0,
                            0,
                            index == snapshot.data!.docs.length - 1 ? 70 : 0,
                          ),
                          child: doc['upvotedUsers']
                                  .contains(_user.currentUser!.uid)
                              ? tile(doc, true)
                              : InkWell(
                                  onTap: () {
                                    upvoteSong(doc.id);
                                  },
                                  child: tile(doc, false),
                                ),
                        );
                      } else {
                        if (doc['upvotedUsers']
                            .contains(_user.currentUser!.uid)) {
                          return tile(doc, true);
                        } else {
                          return InkWell(
                            onTap: () {
                              upvoteSong(doc.id);
                            },
                            child: tile(doc, false),
                          );
                        }
                      }
                    },
                  );
                }
              })),
    );
  }
}
