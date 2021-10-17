import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/models/member.dart';
import 'package:wapp/pages/general_page/general_page_app_bar.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

Random random = new Random();

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
        altColor: dark_blue,
        imgURL: "https://i.imgur.com/AJWRskZ.jpg",
        desc: '"Add me on Clash Royale"'),
    Member(
        name: "Lillian Liu",
        role: "Visual Media Manager",
        altRole: "Sleeps a lot",
        altColor: Color(0XFFFFB5E9),
        imgURL: "https://i.imgur.com/v9HeuxA.jpg",
        desc: '"I really like cheese"'),
    Member(
        name: "John Ibrahim",
        role: "Operations Manager",
        altRole: "Spreadsheet God",
        altColor: Color(0XFFFF4B4B),
        imgURL: "https://i.imgur.com/fC3GBkB.jpg",
        desc: '"I am Joob."'),
    Member(
        name: "Aayush Panda",
        role: "Developer",
        altRole: "I like planes",
        altColor: Color(_getColorFromHex('#86CEEB')),
        imgURL: "https://i.imgur.com/Axm76yZ.jpg",
        desc: '"I like planes"'),
    Member(
        name: "Jeffrey-Kai Li",
        role: "Developer",
        altRole: "Immortal 800",
        altColor: Color(_getColorFromHex('#b5b9ff')),
        imgURL: "https://i.imgur.com/Ilc65RB.jpg",
        desc: '"I play Valorant"'),
    Member(
        name: "Catherine Zhang",
        role: "Designer",
        altRole: "@aspcaton",
        altColor: Color(0XFFFFB819),
        imgURL: "https://i.imgur.com/5Q5sUcB.jpg",
        desc: '"I draw a lot"'),
    Member(
        name: "Gianni Tse",
        role: "Designer",
        altRole: "MOOOOOO",
        altColor: Color(0XFF1A2551),
        imgURL: "https://i.imgur.com/X2mNLth.jpg",
        desc: '"I sleep a lot"'),
    Member(
        name: "Kelly Ng",
        role: "Designer",
        altRole: "Cereal Bowl",
        altColor: Color(_getColorFromHex('#88B9FF')),
        imgURL: "https://i.imgur.com/FO3TNuU.jpg",
        desc: '"I do not sleep a lot"'),
    Member(
        name: "Vishnu Satish",
        role: "Developer",
        altRole: "RCB",
        altColor: Color(_getColorFromHex('#ffa941')),
        imgURL: "https://i.imgur.com/MRIibBL.jpg",
        desc: '"I love cricket"'),
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
      body: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  infoCard(
                      context,
                      members[index].name,
                      members[index].role,
                      members[index].altRole,
                      members[index].altColor,
                      members[index].imgURL,
                      members[index].desc)
                ],
              );
            }
            return infoCard(
                context,
                members[index].name,
                members[index].role,
                members[index].altRole,
                members[index].altColor,
                members[index].imgURL,
                members[index].desc);
          }),
    );
  }

  Widget infoCard(BuildContext context, String name, String role,
      String altRole, Color altColor, String imgURL, String desc) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: FlipCard(
            speed: 370,
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
                      height: 140,
                      width: 220,
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
                child: name == 'Aayush Panda'
                    ? Container(
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: new DecorationImage(
                              image: random.nextInt(7) != 1
                                  ? new NetworkImage(
                                      'https://c.tenor.com/yo1fCgCiyQ4AAAAC/f14-grumman.gif')
                                  : new NetworkImage(
                                      'https://c.tenor.com/Z6gmDPeM6dgAAAAC/dance-moves.gif'),
                              fit: BoxFit.cover,
                            )),
                      )
                    : name == 'Abhinav Balasubramanian'
                        ? Container(
                            child: CarouselSlider(
                              items: [
                                //1st Image of Slider
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.imgur.com/TqRFe9F.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //2nd Image of Slider
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.imgur.com/Q1lBoIi.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //3rd Image of Slider
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.imgur.com/KEN73P2.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //4th Image of Slider
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.imgur.com/7oxsCzB.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                //5th Image of Slider
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://i.imgur.com/OVdbJLm.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],

                              //Slider Container properties
                              options: CarouselOptions(
                                height: 180.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                          )
                        : name == 'John Ibrahim'
                            ? Container(
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: new DecorationImage(
                                      image: new NetworkImage(
                                          'https://i.imgur.com/KVo5AUo.jpg'),
                                      fit: BoxFit.cover,
                                    )),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
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
                              ))));
  }
}
