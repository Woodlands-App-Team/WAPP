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
        //padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          ClubPageTile(),
          ClubPageTile(),
          ClubPageTile(),
          ClubPageTile(),
        ],
      ),
    );
  }
}
