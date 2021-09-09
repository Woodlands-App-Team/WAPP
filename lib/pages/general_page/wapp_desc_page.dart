import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/models/member.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';

int _getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");

  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return int.parse(hexColor, radix: 16);
}

class WappDescPage extends StatelessWidget {
  const WappDescPage({Key? key}) : super(key: key);

  static List<Member> members = [
    Member(
        name: "Abhinav Balasubramanian",
        role: "President",
        altRole: "Supreme Overlord",
        altColor: Color(_getColorFromHex('#4b0082')),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"Add me on Clash Royale xD"'),
    Member(
        name: "Lillian Liu",
        role: "Executive",
        altRole: "Abhinav's #1 Simp",
        altColor: Color(0XFFFFB5E9),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"I am short."'),
    Member(
        name: "John Ibrahim",
        role: "Executive",
        altRole: "Abhinav's #2 Simp",
        altColor: Color(0XFFFF4B4B),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"I love Abhinav"'),
    Member(
        name: "Aayush Panda",
        role: "Developer",
        altRole: "Something Random",
        altColor: Color(_getColorFromHex('#87CEEB')),
        imgURL:
            "https://miro.medium.com/fit/c/262/262/1*juqzL_lv5ZEuhlHZr_RB2g.png",
        desc: '"I like planes"'),
    Member(
        name: "Jeffrey-Kai Li",
        role: "Developer",
        altRole: "Immortal 800",
        altColor: Color(_getColorFromHex('#b5b9ff')),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"I play Valorant."'),
    Member(
        name: "Catherine Zhang",
        role: "Designer",
        altRole: "Your Mother's Significant Other",
        altColor: Color(0XFFFFB819),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"I draw."'),
    Member(
        name: "Gianni Tse",
        role: "Designer",
        altRole: "Fat Cow",
        altColor: Color(0XFF1A2551),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"I sleep."'),
    Member(
        name: "Kelly Ng",
        role: "Designer",
        altRole: "Extremely Short",
        altColor: Color(_getColorFromHex('#88B9FF')),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"I am shorter than John"'),
    Member(
        name: "Vishnu Satish",
        role: "Developer",
        altRole: "Poggers",
        altColor: Color(_getColorFromHex('#ffa941')),
        imgURL:
            "https://img.cinemablend.com/filter:scale/quill/6/8/5/b/5/e/685b5edda326d2bd77ca9709647e913d7875af4f.jpg?mw=600",
        desc: '"Sup guys! I am Vishnu."'),
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
        padding: const EdgeInsets.only(top: 45),
        child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              return infoCard(
                  context,
                  members[index].name,
                  members[index].role,
                  members[index].altRole,
                  members[index].altColor,
                  members[index].imgURL,
                  members[index].desc);
            }),
      ),
    );
  }

  Widget infoCard(BuildContext context, String name, String role,
      String altRole, Color altColor, String imgURL, String desc) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: FlipCard(
        speed: 400,
        direction: FlipDirection.VERTICAL,
        front: Card(
          color: dark_blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: light_blue,
                      image: DecorationImage(
                          image: NetworkImage(imgURL), fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(name,
                    style: GoogleFonts.poppins(
                      color: white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                Text(role,
                    style: GoogleFonts.poppins(
                      color: light_blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          ),
        ),
        back: Card(
          color: altColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(name,
                        style: GoogleFonts.poppins(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(altRole,
                        style: GoogleFonts.poppins(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      child: Text(desc,
                          style: GoogleFonts.poppins(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
