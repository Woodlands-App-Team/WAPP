import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/pages/announcements_page/announcement_page_app_bar.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: announcementPageAppBar(),
      backgroundColor: dark_blue,
    );
  }
}
