import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/pages/announcements_page/announcements_page.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page.dart';
import 'package:wapp/pages/club_page/club_page.dart';
import 'package:wapp/pages/general_page/general_page.dart';
import 'package:wapp/pages/home_page/home_page_app_bar.dart';
import 'package:wapp/pages/song_req_page/song_req_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;

  // ignore: unused_field
  int _currentIndex = 3;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: homePageAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          CafMenuPage(),
          SongReqPage(),
          AnnouncementsPage(),
          ClubPage(),
          GeneralPage(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        alignment: Alignment.topCenter,
        color: black,
        height: 80,
        child: TabBar(
          physics: BouncingScrollPhysics(),
          controller: _tabController,
          unselectedLabelColor: grey,
          labelColor: white,
          indicatorColor: black,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Image.asset('assets/logo.png'),
            ),
            Tab(
              icon: Icon(Icons.library_music),
            ),
            Tab(
              icon: Icon(Icons.group_work),
            ),
            Tab(
              icon: Icon(Icons.settings),
            ),
          ],
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
