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
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: mpKeys.length,
                itemBuilder: (context, index) {
                  return ClubPageTile(
                    title: mpKeys[index],
                    logo: clubData[mpKeys[index]]["logo"],
                    meetingTime: clubData[mpKeys[index]]["meetingTime"],
                    topic: mpKeys[index],
                    description:
                        clubData[mpKeys[index]]["description"].toString(),
                  );
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
