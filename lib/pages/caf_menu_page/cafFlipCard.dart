import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';

class cafFlipCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new cafFlipCardState();
  }

  const cafFlipCard({
    Key? key,
    required String this.imageAddress,
    required String this.title,
    required String this.price,
    required String this.flipText,
  }) : super(key: key);

  final String imageAddress;
  final String title;
  final String price;
  final String flipText;
}

class cafFlipCardState extends State<cafFlipCard> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      front: Container(
        width: MediaQuery.of(context).size.width * 0.9 / 2,
        height: MediaQuery.of(context).size.width * 0.9 / 2,
        padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(widget.imageAddress,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.7 / 4,
                  fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                child: AutoSizeText(widget.title,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: black,
                      fontSize: 20, //45
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
                  child: Text(widget.price,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        color: grey,
                        fontSize: 18, //45
                        fontWeight: FontWeight.normal,
                      )))
            ],
          ),
        ),
      ),
      back: Container(
        width: MediaQuery.of(context).size.width * 0.9 / 2,
        height: MediaQuery.of(context).size.width * 0.9 / 2,
        padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
              child: Text(widget.flipText,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: black,
                    fontSize: 20, //45
                    fontWeight: FontWeight.normal,
                  ))),
        ),
      ),
    );
  }
}
