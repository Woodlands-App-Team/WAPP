import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:spotify/spotify.dart';
import './spotify_get.dart';

class SongSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: TypeAheadField<Track?>(
          hideSuggestionsOnKeyboardHide: false,
          debounceDuration: Duration(milliseconds: 500),
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: "Search Song",
            ),
          ),
          suggestionsCallback: SpotifySongApi.getTracks,
          itemBuilder: (context, Track? songData) {
            final song = songData!;
            return ListTile(
              leading: img.Image.network(
                song.album.images.last.url,
                fit: BoxFit.cover,
              ),
              title: Text(song.name),
            );
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
    );
  }
}
