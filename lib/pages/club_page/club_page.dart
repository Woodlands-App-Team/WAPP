import 'package:flutter/material.dart';

import './club_page_tile.dart';
import './club_page_app_bar.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({Key? key}) : super(key: key);

  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: clubPageAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          ClubPageTile(
            title: "SAC",
            logo: "https://avatars1.githubusercontent.com/u/72957331?s=280&v=4",
            meetingTime: "Monday 12:00",
            topic: "SAC",
          ),
          ClubPageTile(
            title: "Woodlands Athletic Association",
            logo: "https://avatars1.githubusercontent.com/u/72957331?s=280&v=4",
            meetingTime: "Monday 12:00",
            topic: "Woodlands Athletic Association",
          ),
          ClubPageTile(
            title: "Woodlands Computer Science Club",
            logo: "https://avatars1.githubusercontent.com/u/72957331?s=280&v=4",
            meetingTime: "Monday 12:00",
            topic: "Woodlands Computer Science Club",
          ),
          ClubPageTile(
            title: "Eco Club",
            logo: "https://avatars1.githubusercontent.com/u/72957331?s=280&v=4",
            meetingTime: "Monday 12:00",
            topic: "Eco Club",
          ),
          ClubPageTile(
            title: "The Prefects",
            logo: "https://avatars1.githubusercontent.com/u/72957331?s=280&v=4",
            meetingTime: "Monday 12:00",
            topic: "The Prefects",
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
