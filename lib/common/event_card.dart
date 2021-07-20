import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wapp/common/constants.dart';

class EventCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;
  final String month;
  final String date;

  EventCard(
      { Key? key,
        required this.titleText,
        required this.descriptionText,
        required this.imageUrl,
        required this.month,
        required this.date})
      : super(key: key);

  _Event_CardState createState() => _Event_CardState();
}

class _Event_CardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: primary,
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
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: AutoSizeText(
                              widget.titleText,
                              maxLines: 1,
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
                          color: primary,
                        ),
                        child: Text(
                          widget.descriptionText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
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
                                child: AutoSizeText(
                                  widget.month,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: white,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(0, 0),
                                child: AutoSizeText(
                                  widget.date,
                                  maxLines: 1,
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
