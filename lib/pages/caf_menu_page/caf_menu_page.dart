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
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _foodController;
  final DateTime date = DateTime.now();
  int _selectedIndex = 0;
  int _foodSelectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    _foodController = TabController(length: 4, initialIndex: 0, vsync: this);
    super.initState();
  }

  Future<DocumentSnapshot> getFoodItems() async {
    DocumentSnapshot foodItems = await FirebaseFirestore.instance
        .collection('food-items')
        .doc('S8m4MjTdNwoGNIR7tRjY')
        .get();
    return foodItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F5F2),
      appBar: cafMenuPageAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.fromLTRB(2, 15, 2, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: dayText('Daily Specials')),
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
                height: 200,
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TabBar(
                  isScrollable: true,
                  enableFeedback: false,
                  labelPadding: EdgeInsets.all(0),
                  unselectedLabelColor: grey,
                  labelColor: light_blue,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _foodController,
                  tabs: [
                    foodButton('All'),
                    foodButton('Meals'),
                    foodButton('Drinks'),
                    foodButton('Snacks'),
                  ]),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: Container(
                  child: FutureBuilder<DocumentSnapshot>(
                      future: getFoodItems(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data!.exists) {
                          final allFoodItem = snapshot.data!.data();
                          List mealItem = [];
                          List drinkItem = [];
                          List snackItem = [];
                          for (int i = 0;
                              i < allFoodItem!['foodItems'].length;
                              i++) {
                            if (allFoodItem['foodItems'][i]['type'] == 'Food') {
                              mealItem.add(allFoodItem['foodItems'][i]);
                            } else if (allFoodItem['foodItems'][i]['type'] ==
                                'Drink') {
                              drinkItem.add(allFoodItem['foodItems'][i]);
                            } else {
                              snackItem.add(allFoodItem['foodItems'][i]);
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _foodController,
                                children: [
                                  GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount:
                                          allFoodItem['foodItems'].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return cafFlipCard(
                                            imageAddress:
                                                allFoodItem['foodItems'][index]
                                                    ['imgURL'],
                                            title: allFoodItem['foodItems']
                                                [index]['title'],
                                            price: allFoodItem['foodItems']
                                                [index]['price'],
                                            flipText: allFoodItem['foodItems']
                                                [index]['flipText']);
                                      }),
                                  GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: mealItem.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return cafFlipCard(
                                            imageAddress: mealItem[index]
                                                ['imgURL'],
                                            title: mealItem[index]['title'],
                                            price: mealItem[index]['price'],
                                            flipText: mealItem[index]
                                                ['flipText']);
                                      }),
                                  GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: drinkItem.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return cafFlipCard(
                                            imageAddress: drinkItem[index]
                                                ['imgURL'],
                                            title: drinkItem[index]['title'],
                                            price: drinkItem[index]['price'],
                                            flipText: drinkItem[index]
                                                ['flipText']);
                                      }),
                                  GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: snackItem.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return cafFlipCard(
                                            imageAddress: snackItem[index]
                                                ['imgURL'],
                                            title: snackItem[index]['title'],
                                            price: snackItem[index]['price'],
                                            flipText: snackItem[index]
                                                ['flipText']);
                                      }),
                                ]),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }

  Widget dayButton(String day) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(day,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget foodButton(String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Text(name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget dayText(String day) {
    return Text(
      day,
      style: GoogleFonts.poppins(
          color: dark_blue, fontSize: 24, fontWeight: FontWeight.w600),
    );
  }
}
