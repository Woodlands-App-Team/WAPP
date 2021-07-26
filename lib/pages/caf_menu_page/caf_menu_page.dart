import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/pages/caf_menu_page/caf_menu_page_app_bar.dart';

class CafMenuPage extends StatefulWidget {
  const CafMenuPage({Key? key}) : super(key: key);

  @override
  _CafMenuPageState createState() => _CafMenuPageState();
}

class _CafMenuPageState extends State<CafMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cafMenuPageAppBar(),
      backgroundColor: light_blue,
    );
  }
}
