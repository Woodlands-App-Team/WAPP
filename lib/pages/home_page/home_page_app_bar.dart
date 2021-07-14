import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wapp/constants.dart';
import 'package:intl/intl.dart';

PreferredSizeWidget homePageAppBar() {
  final DateTime date = DateTime.now();

  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    toolbarHeight: 75,
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE').format(date) + ",",
          style: TextStyle(fontWeight: bold, fontSize: 20),
        ),
        Text(
          DateFormat('MMMMd').format(date),
          style: TextStyle(fontWeight: semibold),
        ),
      ],
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
