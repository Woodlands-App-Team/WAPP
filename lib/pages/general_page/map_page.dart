import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/custom_icons_icons.dart';
import 'package:photo_view/photo_view.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width - 75,
        ),
        child: FloatingActionButton(
          highlightElevation: 0,
          hoverColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.chevron_back,
            size: 40,
            color: white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
          child: PhotoView(
        imageProvider: AssetImage("assets/school_map.png"),
      )),
    );
  }
}
