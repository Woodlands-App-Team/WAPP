import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:wapp/pages/announcements_page/announcement_page_app_bar.dart';
import 'announcement_card.dart';

String title = "App Team";
String description =
    "Most of the development will be done in the summer. Members will need to complete assigned tasks within established timelines so that the app can be deployed by the end of summer at the earliest";
String month = "Apr";
String date = "20";
String imageAddress =
    'https://avatars.githubusercontent.com/u/86990803?s=200&v=4';
String expandedImageAddress =
    "https://cdn.vox-cdn.com/thumbor/IQab79SuQ1PnrneGti_uy_pxTKo=/148x0:1768x1080/1280x854/cdn.vox-cdn.com/uploads/chorus_image/image/47413330/the-simpsons-tv-series-cast-wallpaper-109911.0.0.jpeg";

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  late TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    textController = TextEditingController();
    return Scaffold(
      appBar: announcementPageAppBar(),
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xB222221219),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 13, 0, 0),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: ' Search posts...',
                        hintStyle: TextStyle(fontFamily: 'Poppins'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      Text(
                        'All',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Announcements',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Events',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      AnnouncementCard(
                          titleText: title,
                          descriptionText: description,
                          imageUrl: imageAddress,
                          expandedImageUrl: expandedImageAddress)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
