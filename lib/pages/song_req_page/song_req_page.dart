import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:wapp/pages/song_req_page/song_req_page_app_bar.dart';
import 'package:profanity_filter/profanity_filter.dart';

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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<Widget> topSongs;
  final filter = ProfanityFilter();
  SongReqScreen(this.topSongs);

  Future<String> requestSong(Track song) async {
    String date = DateTime.now().toString();

    HttpsCallable requestSong = functions.httpsCallable('requestSong');
    dynamic songName = await requestSong.call(<String, dynamic>{
      "name": song.name,
      "artist": song.artist,
      "imgURL": song.imgURL,
      "date": date,
      "uid": auth.currentUser!.uid,
      "songName": song.songURL,
    });
    print(song.songURL);
    return songName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: songReqPageAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(14, 16, 14, 0),
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
              suggestionsBoxVerticalOffset: 0,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                constraints: new BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
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
                  requestSong(selected);
                  output = "Song Requested";
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
  FirebaseFunctions functions = FirebaseFunctions.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future requestSong(Track song) async {
    String date = DateTime.now().toString();

    HttpsCallable requestSong = functions.httpsCallable('requestSong');
    dynamic songName = await requestSong.call(<String, dynamic>{
      "name": song.name,
      "artist": song.artist,
      "imgURL": song.imgURL,
      "date": date,
      "uid": auth.currentUser!.uid,
      "songName": song.songURL,
    });
    print(song.songURL);
  }

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
                      requestSong(song);
                      output = "Selected song: ${song.name}";
                      Navigator.of(context).pop();
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
