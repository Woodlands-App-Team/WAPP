import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget songUpvotePageAppBar() {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    toolbarHeight: appBarHeight,
    centerTitle: false,
    title: Text(
      "Song Upvote",
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: white,
      ),
    ),
    brightness: Brightness.dark,
    backgroundColor: black,
    actions: [
      Container(
        padding: EdgeInsets.fromLTRB(5, 10, 17, 15),
        child: Image.asset('assets/logo.png'),
      ),
    ],
  );
}
