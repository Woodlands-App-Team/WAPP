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
            title: "WAA",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "WAA",
          ),
          ClubPageTile(
            title: "WAA",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "WAA",
          ),
          ClubPageTile(
            title: "WAA",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "WAA",
          ),
          ClubPageTile(
            title: "WAA",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "WAA",
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
