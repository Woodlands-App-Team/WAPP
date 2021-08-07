import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalPageAppBar(),
      backgroundColor: Color(0XFFF7F5F2),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: GestureDetector(
                onTap: () {
                  print("I have been tapped");
                },
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
