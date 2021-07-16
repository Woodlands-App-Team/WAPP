import 'package:flutter/material.dart';
import 'package:wapp/common/constants.dart';

class AnnouncementCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;
  final String month;
  final String date;

  AnnouncementCard(
      {Key key,
        @required this.titleText,
        @required this.descriptionText,
        @required this.imageUrl,
        @required this.month,
        @required this.date})
      : super(key: key);

  _Announcement_CardState createState() => _Announcement_CardState();
}

class _Announcement_CardState extends State<AnnouncementCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: red,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Container(
                          width:
                          MediaQuery.of(context).size.width * 0.15,
                          height:
                          MediaQuery.of(context).size.width * 0.15,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                              widget.imageUrl
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment(-1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              widget.titleText,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: white,
                                fontSize: 45,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 100,
                        decoration: BoxDecoration(
                          color: red,
                        ),
                        child: Text(
                          widget.descriptionText,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: white,
                            fontSize: 16.5,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00FF0000),
                        ),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: Alignment(0, -2),
                                child: Text(
                                  widget.month,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: white,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0, 0),
                                child: Text(
                                  widget.date,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: white,
                                    fontSize: 45,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
