import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/custom_icons_icons.dart';
import 'package:wapp/pages/announcements_page/announcements_page.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page.dart';
import 'package:wapp/pages/club_page/club_page.dart';
import 'package:wapp/pages/general_page/general_page.dart';
import 'package:wapp/pages/song_req_page/song_req_page.dart';
import 'dart:math';

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
  int _currentIndex = 0;

  late PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
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
          SongReqPage(),
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
              if (now - lastTap < 1000) {
                consecutiveTaps++;
                if (consecutiveTaps >= 7) {
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
