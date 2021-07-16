import 'package:flutter/material.dart';
import 'package:wapp/common/constants.dart';

class EventCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;

  EventCard(
      {Key key,
        @required this.titleText,
        @required this.descriptionText,
        @required this.imageUrl})
      : super(key: key);

  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: grey,
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 100,
                        decoration: BoxDecoration(
                          color: grey,
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
