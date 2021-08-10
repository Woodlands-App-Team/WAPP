import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';

class SpecialCard extends StatefulWidget {
  const SpecialCard({
    Key? key,
    required this.specials,
  }) : super(key: key);

  final List<dynamic> specials;

  @override
  State<SpecialCard> createState() => _SpecialCardState();
}

class _SpecialCardState extends State<SpecialCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
              height: 220,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width - 150,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              List.generate(widget.specials.length, (index) {
                            return Center(
                              child: Text(
                                widget.specials[index]['name'],
                                style: GoogleFonts.poppins(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            );
                          })),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: dark_blue,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              List.generate(widget.specials.length, (index) {
                            return Text(
                              widget.specials[index]['price'],
                              style: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            );
                          })),
                    ),
                  ),
                ],
              ))),
    );
  }
}
