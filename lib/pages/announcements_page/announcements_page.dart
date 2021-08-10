import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wapp/pages/announcements_page/event_card.dart';
import '../../constants.dart';
import 'package:wapp/pages/announcements_page/announcement_page_app_bar.dart';
import 'announcement_card.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

final db = FirebaseFirestore.instance.collection("announcements");

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  late TextEditingController textController;
  String cardFilter = "all";

  MaterialStateProperty<Color> allButtonColor =
      MaterialStateProperty.all(dark_blue);
  MaterialStateProperty<Color> announcementsButtonColor =
      MaterialStateProperty.all(white);
  MaterialStateProperty<Color> eventsButtonColor =
      MaterialStateProperty.all(white);

  Color allButtonTextColor = white;
  Color announcementsButtonTextColor = black;
  Color eventsButtonTextColor = black;

  @override
  Widget build(BuildContext context) {
    textController = TextEditingController();
    return Scaffold(
      appBar: announcementPageAppBar(),
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xB222221219),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 13, 0, 0),
                    child: Center(
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: ' Search posts...',
                          hintStyle: TextStyle(fontFamily: 'Poppins'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  // Row with filter buttons
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          cardFilter = "all";
                          allButtonColor = MaterialStateProperty.all(dark_blue);
                          announcementsButtonColor =
                              MaterialStateProperty.all(white);
                          eventsButtonColor = MaterialStateProperty.all(white);

                          allButtonTextColor = white;
                          announcementsButtonTextColor = black;
                          eventsButtonTextColor = black;
                          setState(() {});
                        },
                        child: Text(
                          'All',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: allButtonTextColor
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: allButtonColor,
                            ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          cardFilter = "announcements";
                          allButtonColor = MaterialStateProperty.all(white);
                          announcementsButtonColor =
                              MaterialStateProperty.all(dark_blue);
                          eventsButtonColor = MaterialStateProperty.all(white);

                          allButtonTextColor = black;
                          announcementsButtonTextColor = white;
                          eventsButtonTextColor = black;

                          setState(() {});
                        },
                        child: Text(
                          'Announcements',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: announcementsButtonTextColor
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: announcementsButtonColor,
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: announcementsButtonTextColor))),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          cardFilter = "events";
                          allButtonColor = MaterialStateProperty.all(white);
                          announcementsButtonColor =
                              MaterialStateProperty.all(white);
                          eventsButtonColor =
                              MaterialStateProperty.all(dark_blue);

                          allButtonTextColor = black;
                          announcementsButtonTextColor = black;
                          eventsButtonTextColor = white;

                          setState(() {});
                        },
                        child: Text(
                          'Events',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: eventsButtonTextColor
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: eventsButtonColor,
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: eventsButtonTextColor))),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (cardFilter == "all") {
                                  // If filter is for all data
                                  if (snapshot.data!.docs[index]['type'] ==
                                      'announcement') {
                                    return AnnouncementCard(
                                      titleText: snapshot.data!.docs[index]
                                          ['title'],
                                      previewDescriptionText: snapshot
                                          .data!.docs[index]['preview_text']
                                          .replaceAll('"', ''),
                                      expandedDescriptionText: snapshot
                                          .data!.docs[index]['description']
                                          .replaceAll('"', ''),
                                      imageUrl: snapshot.data!.docs[index]
                                          ['logo_url'],
                                      expandedImageUrl: snapshot.data!
                                          .docs[index]['expanded_image_url'],
                                    );
                                  } else {
                                    return EventCard(
                                      titleText: snapshot.data!.docs[index]
                                          ['title'],
                                      previewDescriptionText: snapshot
                                          .data!.docs[index]['preview_text']
                                          .replaceAll('"', ''),
                                      expandedDescriptionText: snapshot
                                          .data!.docs[index]['description']
                                          .replaceAll('"', ''),
                                      imageUrl: snapshot.data!.docs[index]
                                          ['logo_url'],
                                      expandedImageUrl: snapshot.data!
                                          .docs[index]['expanded_image_url'],
                                      date: snapshot.data!.docs[index]['date'],
                                      month: snapshot.data!.docs[index]
                                          ['month'],
                                    );
                                  }
                                } else if (cardFilter == "announcements") {
                                  // If filter is for announcements
                                  if (snapshot.data!.docs[index]['type'] ==
                                      'announcement') {
                                    return AnnouncementCard(
                                      titleText: snapshot.data!.docs[index]
                                          ['title'],
                                      previewDescriptionText: snapshot
                                          .data!.docs[index]['preview_text']
                                          .replaceAll('"', ''),
                                      expandedDescriptionText: snapshot
                                          .data!.docs[index]['description']
                                          .replaceAll('"', ''),
                                      imageUrl: snapshot.data!.docs[index]
                                          ['logo_url'],
                                      expandedImageUrl: snapshot.data!
                                          .docs[index]['expanded_image_url'],
                                    );
                                  }
                                } else {
                                  // If filter is for events
                                  if (snapshot.data!.docs[index]['type'] ==
                                      'event') {
                                    return EventCard(
                                      titleText: snapshot.data!.docs[index]
                                          ['title'],
                                      previewDescriptionText: snapshot
                                          .data!.docs[index]['preview_text']
                                          .replaceAll('"', ''),
                                      expandedDescriptionText: snapshot
                                          .data!.docs[index]['description']
                                          .replaceAll('"', ''),
                                      imageUrl: snapshot.data!.docs[index]
                                          ['logo_url'],
                                      expandedImageUrl: snapshot.data!
                                          .docs[index]['expanded_image_url'],
                                      date: snapshot.data!.docs[index]['date'],
                                      month: snapshot.data!.docs[index]
                                          ['month'],
                                    );
                                  }
                                }
                                return Container(); // Return blank widget when data does not match filter.
                              });
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
