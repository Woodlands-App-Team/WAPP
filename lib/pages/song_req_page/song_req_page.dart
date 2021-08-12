import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:wapp/pages/song_req_page/song_req_page_app_bar.dart';

import '../../models/spotify_get.dart';
import './song_req_tile.dart';
import './song_req_page_app_bar.dart';

class SongReqPage extends StatefulWidget {
  const SongReqPage({Key? key}) : super(key: key);

  @override
  _SongReqPageState createState() => _SongReqPageState();
}

class SongReqScreen extends StatelessWidget {
  FirebaseFunctions functions = FirebaseFunctions.instance;
  final List<Widget> topSongs;
  SongReqScreen(this.topSongs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: songReqPageAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 5),
            child: TypeAheadField<Track?>(
              hideSuggestionsOnKeyboardHide: false,
              debounceDuration: Duration(milliseconds: 500),
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 12, 0, 10),
                  fillColor: Color(0x1A010D15),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      color: Color(0x4D010D15),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                      color: Color(0x4D010D15),
                      width: 1.5,
                    ),
                  ),
                  hintText: "Search songs...",
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Color(0x4D010D15),
                  ),
                ),
              ),
              suggestionsCallback: searchSongs,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                elevation: 0.0,
              ),
              itemBuilder: (context, Track? songData) {
                final song = songData!;
                return Tile(song);
              },
              onSuggestionSelected: (Track? selected) {
                final String output;
                if (selected!.explicit) {
                  output = "Explicit songs are not permitted.";
                } else {
                  // Get the ID of the user who requested the song + song URL/name + time
                  output = "Selected song: ${selected.name}";
                }
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        output,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
              },
            ),
          ),
          if (topSongs.length == 0)
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [...topSongs],
              ),
            )
        ],
      ),
    );
  }
}

class _SongReqPageState extends State<SongReqPage> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: topTracks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> topTrackData = [
              ...(snapshot.data as List<Track>).map((song) {
                return InkWell(
                  child: Tile(song),
                  onTap: () {
                    final String output;
                    if (song.explicit) {
                      output = "Explicit songs are not permitted.";
                    } else {
                      // Get the ID of the user who requested the song + song URL/name + time
                      output = "Selected song: ${song.name}";
                    }
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            output,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                  },
                );
              }).toList()
            ];
            return SongReqScreen(topTrackData);
          } else {
            return SongReqScreen([]);
          }
        },
      );
}
