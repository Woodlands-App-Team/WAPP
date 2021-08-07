import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page_app_bar.dart';
import 'package:wapp/pages/caf_menu_page/special_card.dart';

class CafMenuPage extends StatefulWidget {
  const CafMenuPage({Key? key}) : super(key: key);

  @override
  _CafMenuPageState createState() => _CafMenuPageState();
}

class _CafMenuPageState extends State<CafMenuPage> {
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cafMenuPageAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 15, 12, 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  DateFormat('EEEE').format(date) + "'s Menu",
                  style: GoogleFonts.poppins(
                      color: dark_blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            specialCard()
          ],
        ),
      ),
    );
  }
}
