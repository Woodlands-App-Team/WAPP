import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/custom_icons_icons.dart';
import 'package:wapp/models/provider.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';
import 'package:wapp/pages/general_page/info_page.dart';
import 'package:wapp/pages/general_page/map_page.dart';
import 'package:wapp/pages/general_page/wapp_desc_page.dart';
import './settings_page.dart';

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
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
                child: Container(
                  height: 190,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 140,
                          child: Icon(
                            CustomIcons.map,
                            size: 110,
                            color: dark_blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("School Map",
                          style: GoogleFonts.poppins(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconCard(CustomIcons.wapp_team, WappDescPage(), 100,
                    "Woodlands\nApp Team"),
                IconCard(
                    CustomIcons.description, InfoPage(), 100, "School Info"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconCard(CustomIcons.settings, SettingsPage(), 100, "Settings"),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 18,
                    height: MediaQuery.of(context).size.height / 4.2,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: GestureDetector(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.logout();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: 120,
                                  child: Icon(
                                    CustomIcons.logout,
                                    size: 110,
                                    color: Color(0XFFd00000),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text("Logout",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Color(0XFFd00000),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget IconCard(IconData icon, Widget page, double size, String name) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 18,
        height: MediaQuery.of(context).size.height / 4.2,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 120,
                      child: Icon(
                        icon,
                        size: 110,
                        color: dark_blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
