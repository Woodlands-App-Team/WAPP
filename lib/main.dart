import 'package:wapp/common/announcement_card.dart';
import 'package:wapp/common/event_card.dart';
import 'package:flutter/material.dart';

String title = "App Team";
String description =
    "Most of the development will be done in the summer. Members will need to complete assigned tasks from among us and not be sussy";
String month = "Apr";
String date = "20";
String imageAddress = 'https://avatars.githubusercontent.com/u/86990803?s=200&v=4';

void main() => runApp(MaterialApp(home: HomePageWidget()));

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            EventCard(titleText: title, descriptionText: description, imageUrl: imageAddress),
            AnnouncementCard(titleText: title, descriptionText: description, imageUrl: imageAddress, month: month, date: date)
          ],
        ),
      ),
    );
  }
}
