import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/models/info_field.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  static List<InfoField> fields = [
    InfoField(
        name: "Address",
        info: "3325 Erindale Station Road,\nMississauga, L5C1Y5"),
    InfoField(name: "Phone Number", info: "(905) 279-0575"),
    InfoField(name: "Email", info: "woodlands.ss@peelsb.com"),
    InfoField(name: "Principals", info: "Omar Zia\nAntonietta Peluso"),
    InfoField(
        name: "Vice-Principals",
        info: "Art Tinson\nZorica Zikey\nKaren Quinton"),
    InfoField(name: "Office Manager", info: "Sophia Ling"),
    InfoField(name: "Superintendent", info: "Patricia Noble\n(905) 366-8800"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalPageAppBar(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          top: 60,
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
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 50, 16, 26),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 5,
            color: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
              child: ListView.builder(
                itemCount: fields.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          fields[index].name,
                          style: GoogleFonts.poppins(
                              color: dark_blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          fields[index].info,
                          style: GoogleFonts.nunitoSans(
                              color: grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
