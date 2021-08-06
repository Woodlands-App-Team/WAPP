import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:wapp/pages/announcements_page/announcement_page_app_bar.dart';
import 'announcement_card.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

final db = FirebaseFirestore.instance.collection("announcements");

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
                    child: Center(
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return AnnouncementCard(
                                titleText: snapshot.data!.docs[index]['title'],
                                previewDescriptionText: snapshot
                                    .data!.docs[index]['preview_text']
                                    .replaceAll('"', ''),
                                expandedDescriptionText: snapshot
                                    .data!.docs[index]['description']
                                    .replaceAll('"', ''),
                                imageUrl: snapshot.data!.docs[index]
                                    ['logo_url'],
                                expandedImageUrl: snapshot.data!.docs[index]
                                    ['expanded_image_url'],
                              );
                            },
                          );
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
