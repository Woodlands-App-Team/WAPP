import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './club_page_tile.dart';
import './club_page_app_bar.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({Key? key}) : super(key: key);

  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  Future<DocumentSnapshot> _getClubs() async {
    DocumentSnapshot clubs = await FirebaseFirestore.instance
        .collection('club-page')
        .doc('club-info')
        .get();
    return clubs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F5F2),
      appBar: clubPageAppBar(),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getClubs(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data!.exists) {
            final mpKeys = snapshot.data!.data()!.keys.toList();
            final clubData = snapshot.data!.data()!;
            return Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
              child: ListView.builder(
                itemCount: mpKeys.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox(height: 4);
                  } else if (index == mpKeys.length + 1) {
                    return SizedBox(
                      height: 15,
                    );
                  } else {
                    return ClubPageTile(
                      backgroundImage: clubData[mpKeys[index - 1]]
                          ["backgroundImage"],
                      title: mpKeys[index - 1],
                      logo: clubData[mpKeys[index - 1]]["logo"],
                      meetingTime: clubData[mpKeys[index - 1]]["meetingTime"],
                      topic: mpKeys[index - 1],
                      description:
                          clubData[mpKeys[index - 1]]["description"].toString(),
                    );
                  }
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
