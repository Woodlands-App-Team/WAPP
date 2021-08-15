import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/custom_icons_icons.dart';
import 'package:wapp/pages/announcements_page/announcements_page.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page.dart';
import 'package:wapp/pages/club_page/club_page.dart';
import 'package:wapp/pages/general_page/general_page.dart';
import 'package:wapp/pages/song_req_page/song_req_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;

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
            backgroundColor: black,
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
            }),
      ),
    );
  }
}
