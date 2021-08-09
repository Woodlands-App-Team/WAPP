import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../custom_icons.dart';
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
  int _currentIndex = 1;

  late PageController _pageController = PageController(initialPage: 1);

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
                icon: Icon(CustomIcons.home_selected),
                title: SizedBox.shrink(),
              ),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.cafe_selected),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.music_note_selected),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.club_unselected),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.settings_selected),
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
