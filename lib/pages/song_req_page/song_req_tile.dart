import 'package:flutter/material.dart';
import 'spotify_get.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Tile extends StatelessWidget {
  final Track song;
  Tile(this.song);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92.5,
      child: Card(
        elevation: 1,
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 64,
                    width: 64,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: img.Image.network(
                        song.imgURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ), // Image of the tile
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          song.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          song.artist,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    CupertinoIcons.plus,
                    color: Color(0xFF1F489C),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
