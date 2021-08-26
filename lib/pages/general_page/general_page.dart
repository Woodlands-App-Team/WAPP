import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/custom_icons_icons.dart';
import 'package:wapp/models/provider.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';
import 'package:wapp/pages/general_page/map_page.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
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
                            size: 100,
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
              children: [
                IconCard(CustomIcons.wapp_team, MapPage(), 100,
                    "Woodlands\nApp Team"),
                IconCard(
                    CustomIcons.description, MapPage(), 100, "School Info"),
              ],
            ),
            Row(
              children: [
                IconCard(CustomIcons.settings, MapPage(), 100, "Settings"),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 15,
                  height: MediaQuery.of(context).size.height / 4.5,
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
                                width: 100,
                                child: Icon(
                                  CustomIcons.logout,
                                  size: 80,
                                  color: Color(0XFFd00000),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("Logout",
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
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget IconCard(IconData icon, Widget page, double size, String name) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 15,
      height: MediaQuery.of(context).size.height / 4.5,
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
                    width: 100,
                    child: Icon(
                      icon,
                      size: 80,
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
    );
  }
}
