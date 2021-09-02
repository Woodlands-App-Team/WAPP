import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wapp/pages/caf_menu_page/cafFlipCard.dart';
import '../../constants.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page_app_bar.dart';
import 'package:wapp/pages/caf_menu_page/special_card.dart';
import 'cafFlipCard.dart';

class CafMenuPage extends StatefulWidget {
  const CafMenuPage({Key? key}) : super(key: key);

  @override
  _CafMenuPageState createState() => _CafMenuPageState();
}

final db = FirebaseFirestore.instance.collection("caf-menu");

class _CafMenuPageState extends State<CafMenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateTime date = DateTime.now();
  int _selectedIndex = 0;
  List<String> dayOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabChange);
    super.initState();
  }

  void _handleTabChange() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
    print("Selected Index: " + _tabController.index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cafMenuPageAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.fromLTRB(2, 15, 2, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: dayText(dayOfWeek[_selectedIndex])),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TabBar(
                        isScrollable: true,
                        enableFeedback: false,
                        labelPadding: EdgeInsets.all(0),
                        controller: _tabController,
                        unselectedLabelColor: grey,
                        labelColor: light_blue,
                        indicatorColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          dayButton('M'),
                          dayButton('T'),
                          dayButton('W'),
                          dayButton('T'),
                          dayButton('F'),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return TabBarView(
                          physics: ClampingScrollPhysics(),
                          controller: _tabController,
                          children: List.generate(snapshot.data!.docs.length,
                              (index) {
                            return SpecialCard(
                                specials: snapshot.data!.docs[index]
                                    ['specials']);
                          }));
                    }
                  },
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.snapshots(),
                  builder: (context, snapshot) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: snapshot.data!.docs[_selectedIndex]['regItems'].length,
                      itemBuilder: (BuildContext context, int index) {
                        if(snapshot.hasData) {
                          for(var i = 0; i < snapshot.data!.docs[_selectedIndex]['regItems'].length; i++){
                            var cardData = snapshot.data!.docs[_selectedIndex]['regItems'][i];
                            return cafFlipCard(imageAddress: cardData['imageAddress'], title: cardData['name'], price: cardData['price'], flipText: cardData['location']);
                          }
                        } return Container();

                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dayButton(String day) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(day,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget dayText(String day) {
    return Text(
      day + "'s Menu",
      style: GoogleFonts.poppins(
          color: dark_blue, fontSize: 24, fontWeight: FontWeight.w600),
    );
  }
}
