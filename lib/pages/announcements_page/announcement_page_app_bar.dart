import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

PreferredSizeWidget announcementPageAppBar() {
  final DateTime date = DateTime.now();

  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    toolbarHeight: appBarHeight,
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('EEEE').format(date) + ",",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(
          DateFormat('MMMMd').format(date),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
        ),
      ],
    ),
    brightness: Brightness.dark,
    backgroundColor: black,
    actions: [
      Container(
        padding: EdgeInsets.fromLTRB(5, 10, 17, 15),
        child: GestureDetector(
          child: Image.asset('assets/logo.png'),
          onTap: () async {
            await launch(
                "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley");
          },
        ),
      ),
    ],
  );
}
