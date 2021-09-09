import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/models/info_field.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var pushNotifications = false,
      clubNotifications = false,
      eventNotifications = false;

  Future<DocumentSnapshot> _getDocument() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final FirebaseAuth _user = FirebaseAuth.instance;
    DocumentSnapshot document = await users.doc(_user.currentUser!.uid).get();
    return document;
  }

  Future<List<String>> _getClubs() async {
    DocumentSnapshot clubs = await FirebaseFirestore.instance
        .collection('club-page')
        .doc('club-info')
        .get();
    return clubs.data()!.keys.toList();
  }

  Future<void> changeAllClubNotifications() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "push_notif_all_clubs": clubNotifications,
      "push_notif_enabled": true
    });

    final clubs = await _getClubs();

    if (clubNotifications) {
      clubs.forEach((topic) {
        _fcm.subscribeToTopic(topic.replaceAll(' ', ''));
      });
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"push_notif_announcement": clubs});
    } else {
      clubs.forEach((topic) {
        _fcm.unsubscribeFromTopic(topic.replaceAll(' ', ''));
      });
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"push_notif_announcement": []});
    }
  }

  Future<void> changeEventNotifications() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "push_notif_event": eventNotifications,
      "push_notif_enabled": true
    });
    if (eventNotifications) {
      _fcm.subscribeToTopic("events");
    } else {
      _fcm.unsubscribeFromTopic("events");
    }
  }

  Future<void> changePushNotifications(clubs) async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    if (pushNotifications == false) {
      if (clubNotifications == false && eventNotifications == false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({"push_notif_enabled": pushNotifications});
      }
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"push_notif_enabled": pushNotifications});
    }

    if (pushNotifications) {
      clubs.forEach((topic) {
        _fcm.subscribeToTopic(topic.replaceAll(' ', ''));
      });
    } else {
      clubs.forEach((topic) {
        _fcm.unsubscribeFromTopic(topic.replaceAll(' ', ''));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalPageAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 26),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.chevron_back,
                      size: 38,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                  color: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: _getDocument(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data!.exists) {
                        clubNotifications =
                            snapshot.data!.data()!["push_notif_all_clubs"];
                        eventNotifications =
                            snapshot.data!.data()!["push_notif_event"];
                        pushNotifications = (clubNotifications ||
                            eventNotifications ||
                            snapshot.data!.data()!["push_notif_enabled"]);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Switch(
                                  value: pushNotifications,
                                  onChanged: (value) {
                                    setState(() {
                                      pushNotifications = value;
                                    });
                                    final clubs = snapshot.data!
                                        .data()!["push_notif_announcement"];
                                    changePushNotifications(clubs);
                                  },
                                  activeTrackColor: dark_blue,
                                  activeColor: Colors.white,
                                ),
                              ),
                              Text(
                                "Push Notifications",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Switch(
                                  value: clubNotifications,
                                  onChanged: (value) {
                                    setState(() {
                                      clubNotifications = value;
                                      if (value) pushNotifications = true;
                                      changeAllClubNotifications();
                                    });
                                  },
                                  activeTrackColor: dark_blue,
                                  activeColor: Colors.white,
                                ),
                              ),
                              Text(
                                "Club Notifications",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Switch(
                                  value: eventNotifications,
                                  onChanged: (value) {
                                    setState(() {
                                      eventNotifications = value;
                                      if (value) pushNotifications = true;
                                      changeEventNotifications();
                                    });
                                  },
                                  activeTrackColor: dark_blue,
                                  activeColor: Colors.white,
                                ),
                              ),
                              Text(
                                "Event Notifications",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Text(
                              "Privacy Policy",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: dark_blue,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
