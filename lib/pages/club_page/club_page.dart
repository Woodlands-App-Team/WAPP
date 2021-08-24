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
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "SAC",
          ),
          ClubPageTile(
            title: "Woodlands Athletic Association",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "WoodlandsAthleticAssociation",
          ),
          ClubPageTile(
            title: "Woodlands Computer Science Club",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "WoodlandsComputerScienceClub",
          ),
          ClubPageTile(
            title: "Eco Club",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "EcoClub",
          ),
          ClubPageTile(
            title: "The Prefects",
            logo:
                "https://upload.wikimedia.org/wikipedia/en/thumb/3/33/Patrick_Star.svg/220px-Patrick_Star.svg.png",
            meetingTime: "Monday 12:00",
            topic: "ThePrefects",
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
