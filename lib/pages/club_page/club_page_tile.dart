import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wapp/custom_icons_icons.dart';
import './club_page_tile_clicked.dart';

class ClubPageTile extends StatefulWidget {
  final String title;
  final String meetingTime;
  final String logo;
  final String topic;

  ClubPageTile({
    required this.title,
    required this.meetingTime,
    required this.logo,
    required this.topic,
  });

  @override
  _ClubPageTileState createState() => _ClubPageTileState(
        title: this.title,
        logo: this.logo,
        meetingTime: this.meetingTime,
        topic: this.topic,
      );
}

class _ClubPageTileState extends State<ClubPageTile> {
  final String title;
  final String meetingTime;
  final String logo;
  final String topic;

  _ClubPageTileState({
    required this.title,
    required this.meetingTime,
    required this.logo,
    required this.topic,
  });

  bool _notification = false;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> changeNotification() async {
    print("HERE " + _notification.toString());
    print(FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid));
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"push_notif_announcement." + topic: _notification});
  }

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> _getDocument() async {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final FirebaseAuth _user = FirebaseAuth.instance;
      DocumentSnapshot document = await users.doc(_user.currentUser!.uid).get();
      return document;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClubPageInfo()),
        );
      },
      child: Center(
        child: Container(
          height: 250,
          margin: EdgeInsets.only(
            top: 10,
          ),
          child: Stack(
            children: [
              Card(
                elevation: 4.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: FittedBox(
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.network('https://i.imgur.com/ebJuOXi.jpg'),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: FutureBuilder<DocumentSnapshot>(
                      future: _getDocument(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data!.exists) {
                          _notification = snapshot.data!
                              .data()!["push_notif_announcement"][topic];

                          return IconButton(
                            icon: Icon(
                              _notification
                                  ? CustomIcons.notification_filled_ringing
                                  : CustomIcons.notification_unselected,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _notification = !_notification;
                              });
                              if (_notification) {
                                _fcm.subscribeToTopic(topic);
                                changeNotification();
                              } else {
                                _fcm.unsubscribeFromTopic(topic);
                                changeNotification();
                              }
                            },
                          );
                        } else {
                          return IconButton(
                            icon: Icon(
                              _notification
                                  ? CustomIcons.notification_filled_ringing
                                  : CustomIcons.notification_unselected,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _notification = !_notification;
                              });
                              if (_notification) {
                                _fcm.subscribeToTopic(topic);
                                changeNotification();
                              } else {
                                _fcm.unsubscribeFromTopic(topic);
                                changeNotification();
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 95,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: FittedBox(
                                child: Image.network(this.logo),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  this.title,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  this.meetingTime,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
