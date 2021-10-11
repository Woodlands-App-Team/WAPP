import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/upvote_icons.dart';
import 'package:palette_generator/palette_generator.dart';

class SongUpvoteTile extends StatefulWidget {
  final String name;
  final String artist;
  final String imgURL;
  final int upvotes;
  final bool isUpvoted;
  SongUpvoteTile(
      this.name, this.artist, this.imgURL, this.upvotes, this.isUpvoted);

  @override
  _SongUpvoteTileState createState() => _SongUpvoteTileState();
}

class _SongUpvoteTileState extends State<SongUpvoteTile> {
  Future<Color> extractColor(imgURL) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imgURL),
      filters: [],
    );

    Color dominantColor = paletteGenerator.dominantColor!.color;
    return dominantColor.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: extractColor(widget.imgURL),
        builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                height: 120,
                child: Card(
                  elevation: 4,
                  color: dark_blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: snapshot.data,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                child: img.Image.network(
                                  widget.imgURL,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ), // Image of the tile
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      widget.name,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          height: 1.25,
                                          color: white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                    child: Text(
                                      widget.artist,
                                      style: GoogleFonts.nunitoSans(
                                        color: white,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.isUpvoted == true
                                    ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 6, 7),
                                      child: Icon(
                                          Upvote.upvoted,
                                          size: 22,
                                          color: white,
                                        ),
                                    )
                                    : Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 6, 7),
                                      child: Icon(
                                          Upvote.unupvoted,
                                          size: 22,
                                          color: white,
                                        ),
                                    ),
                                Text(
                                  widget.upvotes.toStringAsFixed(0),
                                  style: GoogleFonts.nunitoSans(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3),
                child: Container(
                    height: 120,
                    child: Card(
                        elevation: 4,
                        color: dark_blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ))));
          }
        });
  }
}
