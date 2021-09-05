import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ClubPageInfo extends StatelessWidget {
  final String description;
  final String title;
  final String logo;
  final String meetingTime;
  final String backgroundImage;

  ClubPageInfo({
    required this.title,
    required this.meetingTime,
    required this.logo,
    required this.description,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width - 75,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightElevation: 0,
          elevation: 0,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.chevron_back,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: false,
              leading: Container(),
              elevation: 0,
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    child: Opacity(
                      opacity: 1,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(backgroundImage),
                      ),
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: FittedBox(
                            child: Image.network(
                              logo,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: AutoSizeText(
                            title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: const Color(0xff1f489c),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'every '),
                              TextSpan(
                                text: meetingTime.split(" ")[0],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' at '),
                              TextSpan(
                                text: meetingTime.split(" ")[1],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width * 0.86,
                          child: Text(
                            description.replaceAll(r'\n', '\n\n'),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
