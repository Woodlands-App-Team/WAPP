import 'package:wapp/common/announcement_card.dart';
import 'package:wapp/common/app_icons.dart';
import 'package:wapp/common/event_card.dart';
import 'package:flutter/material.dart';

String title = "App Team";
String description =
    "Most of the development will be done in the summer. Members will need to complete assigned tasks from among us and not be sussy";
String month = "Apr";
String date = "20";
String imageAddress =
    'https://avatars.githubusercontent.com/u/86990803?s=200&v=4';

String title_1 = "Shakespeare club extra char to make long";
String description_1 =
    "What a piece of work is a man! How noble in reason, how infinite in faculty! In form and moving how express and admirable! In action how like an angel, in apprehension how like a god! The beauty of the world. The paragon of animals.";

void main() => runApp(MaterialApp(home: HomePageWidget()));

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      Text(
                        'All',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Announcements',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Events',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      // Things to be shown in the listview
                      EventCard(
                          titleText: title,
                          descriptionText: description,
                          imageUrl: imageAddress,
                          month: month,
                          date: date),
                      AnnouncementCard(
                          titleText: title_1,
                          descriptionText: description_1,
                          imageUrl: imageAddress),
                      EventCard(
                          titleText: title_1,
                          descriptionText: description_1,
                          imageUrl: imageAddress,
                          month: month,
                          date: date),
                      AnnouncementCard(
                          titleText: title,
                          descriptionText: description,
                          imageUrl: imageAddress),
                      EventCard(
                          titleText: title,
                          descriptionText: description,
                          imageUrl: imageAddress,
                          month: month,
                          date: date),
                      AnnouncementCard(
                          titleText: title,
                          descriptionText: description,
                          imageUrl: imageAddress)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
              icon: Icon(appIcons.club_selected), label: ""),
          BottomNavigationBarItem(
            icon: Icon(appIcons.music_note_selected),
            label: "Song req",
          ),
          BottomNavigationBarItem(
            icon: Icon(appIcons.home_selected),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(appIcons.cafe_selected),
            label: "Caf menu",
          ),
          BottomNavigationBarItem(
              icon: Icon(appIcons.settings_selected), label: "Settings"),
        ],
      ),
    );
  }
}
