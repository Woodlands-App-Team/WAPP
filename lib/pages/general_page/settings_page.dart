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
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

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

  Future<String> getTextData() async {
    String url =
        'https://raw.githubusercontent.com/Woodlands-App-Team/Privacy-Policy/master/Privacy-Policy.md';
    var response = await http.get(Uri.parse(url));
    return response.body;
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
                          Expanded(
                            child: Center(
                              child: FutureBuilder(
                                future: getTextData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Markdown(
                                        data: snapshot.data as String,
                                        styleSheet: MarkdownStyleSheet(
                                          p: GoogleFonts.poppins(),
                                        ));
                                  }
                                  return Container();
                                },
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
