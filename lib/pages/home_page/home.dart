import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/custom_icons_icons.dart';
import 'package:wapp/pages/announcements_page/announcements_page.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page.dart';
import 'package:wapp/pages/club_page/club_page.dart';
import 'package:wapp/pages/general_page/general_page.dart';
import 'package:wapp/pages/song_req_page/song_req_page.dart';
import 'package:wapp/services/local_notification_service.dart';
import 'dart:math';
import 'package:wapp/pages/song_upvote_page/song_upvote_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;

  Color bottomNavBarColor = black;
  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;
  bool changedColour = false;

  List<String> colours = [
    "#00ffff",
    "#f0ffff",
    "#f5f5dc",
    "#000000",
    "#0000ff",
    "#a52a2a",
    "#00ffff",
    "#ff00ff",
    "#ffd700",
    "#008000",
    "#4b0082",
    "#f0e68c",
    "#add8e6",
    "#e0ffff",
    "#90ee90",
    "#d3d3d3",
    "#ffb6c1",
    "#ffffe0",
    "#00ff00",
    "#ff00ff",
    "#800000",
    "#000080",
    "#808000",
    "#ffa500",
    "#ffc0cb",
    "#800080",
    "#800080",
    "#ff0000",
    "#c0c0c0",
    "#ffffff",
    "#ffff00"
  ];

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");

    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }

    return int.parse(hexColor, radix: 16);
  }

  // ignore: unused_field
  int _currentIndex = 4;

  late PageController _pageController = PageController(initialPage: 4);

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final route = message.data['route'];
        print(route);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      // For when app is in the foreground
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // For when app is in background but not closed
      // final route = message.data['route'];
      // print(route);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          AnnouncementsPage(),
          CafMenuPage(),
          SongUpvotePage(),
          ClubPage(),
          GeneralPage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: white,
            unselectedItemColor: grey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bottomNavBarColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.announcements,
                  size: 35,
                ),
                title: SizedBox.shrink(),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.cafe,
                    size: 35,
                  ),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.music_note,
                    size: 35,
                  ),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.club,
                    size: 35,
                  ),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.miscellaneous,
                    size: 35,
                  ),
                  title: SizedBox.shrink()),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(
                index,
              );

              int now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastTap < 750) {
                consecutiveTaps++;
                if (consecutiveTaps >= 12) {
                  if (changedColour == false) {
                    setState(() {
                      bottomNavBarColor = Color(
                          _getColorFromHex(colours[Random().nextInt(30)]));
                    });
                    consecutiveTaps = 0;
                    changedColour = true;
                  } else {
                    bottomNavBarColor = black;
                    changedColour = false;
                    consecutiveTaps = 0;
                  }
                }
              } else {
                consecutiveTaps = 0;
              }
              lastTap = now;
            }),
      ),
    );
  }
}
