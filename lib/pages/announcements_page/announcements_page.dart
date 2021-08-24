import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/pages/announcements_page/event_card.dart';
import '../../constants.dart';
import 'package:wapp/pages/announcements_page/announcement_page_app_bar.dart';
import 'announcement_card.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  late TextEditingController textController;
  String cardFilter = "all";

  MaterialStateProperty<Color> allButtonColor =
      MaterialStateProperty.all(dark_blue);
  MaterialStateProperty<Color> announcementsButtonColor =
      MaterialStateProperty.all(clear);
  MaterialStateProperty<Color> eventsButtonColor =
      MaterialStateProperty.all(clear);

  MaterialStateProperty<Color> allButtonShadowColor =
      MaterialStateProperty.all(defaultShadowColor);
  MaterialStateProperty<Color> announcementsButtonShadowColor =
      MaterialStateProperty.all(clear);
  MaterialStateProperty<Color> eventsButtonShadowColor =
      MaterialStateProperty.all(clear);

  Color allButtonTextColor = white;
  Color announcementsButtonTextColor = black;
  Color eventsButtonTextColor = black;

  String searchString = "";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _loadingAnnouncements = true;
  List<DocumentSnapshot> _announcements = [];
  int _perPage = 7;
  late var _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreAnnouncements = false;
  bool _moreAnnouncementsAvailable = true;

  int filterNMode = 0;

  List<String> getDateAndMonth(String dateString) {
    List<String> output = [];
    List<String> months =
        'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec'.split(' ');
    output.add(dateString.split('/')[1]);
    output.add(months[int.parse(dateString.split('/')[0]) - 1]);

    return output;
  }

  changeFilter() {
    switch (filterNMode) {
      case 0:
        cardFilter = "all";
        allButtonColor = MaterialStateProperty.all(dark_blue);
        announcementsButtonColor = MaterialStateProperty.all(clear);
        eventsButtonColor = MaterialStateProperty.all(clear);

        allButtonShadowColor =
            MaterialStateProperty.all(defaultShadowColor);
        announcementsButtonShadowColor =
            MaterialStateProperty.all(clear);
        eventsButtonShadowColor =
            MaterialStateProperty.all(clear);

        allButtonTextColor = white;
        announcementsButtonTextColor = black;
        eventsButtonTextColor = black;
        setState(() {});
        break;
      case 1:
        cardFilter = "announcements";
        allButtonColor = MaterialStateProperty.all(clear);
        announcementsButtonColor = MaterialStateProperty.all(dark_blue);
        eventsButtonColor = MaterialStateProperty.all(clear);

        allButtonShadowColor =
            MaterialStateProperty.all(clear);
        announcementsButtonShadowColor =
            MaterialStateProperty.all(defaultShadowColor);
        eventsButtonShadowColor =
            MaterialStateProperty.all(clear);

        allButtonTextColor = black;
        announcementsButtonTextColor = white;
        eventsButtonTextColor = black;
        setState(() {});
        break;
      case 2:
        cardFilter = "events";
        allButtonColor = MaterialStateProperty.all(clear);
        announcementsButtonColor = MaterialStateProperty.all(clear);
        eventsButtonColor = MaterialStateProperty.all(dark_blue);

        allButtonShadowColor =
            MaterialStateProperty.all(clear);
        announcementsButtonShadowColor =
            MaterialStateProperty.all(clear);
        eventsButtonShadowColor =
            MaterialStateProperty.all(defaultShadowColor);

        allButtonTextColor = black;
        announcementsButtonTextColor = black;
        eventsButtonTextColor = white;
        setState(() {});
        break;
    }
  }

  _getMoreAnnouncements() async {
    print("Getting more announcements");

    if (!_moreAnnouncementsAvailable) {
      print("no more announcements!");
      return;
    }

    if (_gettingMoreAnnouncements) {
      return;
    }

    _gettingMoreAnnouncements = true;

    Query q = _firestore
        .collection('announcements')
        .orderBy('timestamp')
        .startAfter([_lastDocument.data()['timestamp']]).limit(_perPage);

    QuerySnapshot querySnapshot = await q.get();

    setState(() {
      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      _announcements.addAll(querySnapshot.docs);

      if (querySnapshot.docs.length < _perPage) {
        _moreAnnouncementsAvailable = false;
      }
    });

    _gettingMoreAnnouncements = false;
  }

  _getAnnouncements() async {
    Query q =
        _firestore.collection('announcements').orderBy('timestamp').limit(5);

    setState(() {
      _loadingAnnouncements = true;
    });

    QuerySnapshot querySnapshot = await q.get();
    _announcements = querySnapshot.docs;

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loadingAnnouncements = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAnnouncements();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        _getMoreAnnouncements();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    textController = TextEditingController();
    textController.text = searchString;

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
                      child: TextField(
                        onSubmitted: (text) {
                          searchString = text;
                          setState(() {});
                        },
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
                          filterNMode = 0;
                          changeFilter();
                        },
                        child: Text(
                          'All',
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: allButtonTextColor),
                        ),
                        style: ButtonStyle(
                          shadowColor: allButtonShadowColor,
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                          backgroundColor: allButtonColor,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          filterNMode = 1;
                          changeFilter();
                        },
                        child: Text(
                          'Announcements',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: announcementsButtonTextColor),
                        ),
                        style: ButtonStyle(
                            shadowColor: announcementsButtonShadowColor,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0))),
                            backgroundColor: announcementsButtonColor,
                            textStyle: MaterialStateProperty.all(TextStyle(
                                color: announcementsButtonTextColor))),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          filterNMode = 2;
                          changeFilter();
                        },
                        child: Text(
                          'Events',
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: eventsButtonTextColor),
                        ),
                        style: ButtonStyle(
                            shadowColor: eventsButtonShadowColor,
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0))),
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
                    child: _loadingAnnouncements == true
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : _announcements.length == 0
                            ? Center(
                                child: Text(
                                  "No announcements found",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: _announcements.length - 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_announcements[index]['title']
                                          .toUpperCase()
                                          .contains(
                                              searchString.toUpperCase()) ||
                                      _announcements[index]['preview_text']
                                          .toUpperCase()
                                          .replaceAll('"', '')
                                          .contains(
                                              searchString.toUpperCase()) ||
                                      _announcements[index]['description']
                                          .toUpperCase()
                                          .replaceAll('"', '')
                                          .contains(
                                              searchString.toUpperCase()) ||
                                      _announcements[index]['tags']
                                          .toUpperCase()
                                          .contains(
                                              searchString.toUpperCase())) {
                                    if (cardFilter == "all") {
                                      // If filter is for all data
                                      if (_announcements[index]['type'] ==
                                          'Announcement') {
                                        return AnnouncementCard(
                                          titleText: _announcements[index]
                                              ['title'],
                                          previewDescriptionText:
                                              _announcements[index]
                                                      ['preview_text']
                                                  .replaceAll('"', ''),
                                          expandedDescriptionText:
                                              _announcements[index]
                                                      ['description']
                                                  .replaceAll('"', ''),
                                          imageUrl: _announcements[index]
                                              ['logo_url'],
                                          expandedImageUrl:
                                              _announcements[index]
                                                  ['expanded_image_url'],
                                        );
                                      } else {
                                        return EventCard(
                                          titleText: _announcements[index]
                                              ['title'],
                                          previewDescriptionText:
                                              _announcements[index]
                                                      ['preview_text']
                                                  .replaceAll('"', ''),
                                          expandedDescriptionText:
                                              _announcements[index]
                                                      ['description']
                                                  .replaceAll('"', ''),
                                          imageUrl: _announcements[index]
                                              ['logo_url'],
                                          expandedImageUrl:
                                              _announcements[index]
                                                  ['expanded_image_url'],
                                          date: getDateAndMonth(
                                              _announcements[index]['date'])[0],
                                          month: getDateAndMonth(
                                              _announcements[index]['date'])[1],
                                        );
                                      }
                                    } else if (cardFilter == "announcements") {
                                      // If filter is for announcements
                                      if (_announcements[index]['type'] ==
                                          'Announcement') {
                                        return AnnouncementCard(
                                          titleText: _announcements[index]
                                              ['title'],
                                          previewDescriptionText:
                                              _announcements[index]
                                                      ['preview_text']
                                                  .replaceAll('"', ''),
                                          expandedDescriptionText:
                                              _announcements[index]
                                                      ['description']
                                                  .replaceAll('"', ''),
                                          imageUrl: _announcements[index]
                                              ['logo_url'],
                                          expandedImageUrl:
                                              _announcements[index]
                                                  ['expanded_image_url'],
                                        );
                                      }
                                    } else {
                                      // If filter is for events
                                      if (_announcements[index]['type'] ==
                                          'Event') {
                                        return EventCard(
                                          titleText: _announcements[index]
                                              ['title'],
                                          previewDescriptionText:
                                              _announcements[index]
                                                      ['preview_text']
                                                  .replaceAll('"', ''),
                                          expandedDescriptionText:
                                              _announcements[index]
                                                      ['description']
                                                  .replaceAll('"', ''),
                                          imageUrl: _announcements[index]
                                              ['logo_url'],
                                          expandedImageUrl:
                                              _announcements[index]
                                                  ['expanded_image_url'],
                                          date: getDateAndMonth(
                                              _announcements[index]['date'])[0],
                                          month: getDateAndMonth(
                                              _announcements[index]['date'])[1],
                                        );
                                      }
                                    }
                                  }
                                  return Container(); // Return blank widget when data does not match filter.
                                })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
