import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;

class Track {
  final String name;
  final String artist;
  final String imgURL;
  final bool explicit;

  Track({
    required this.name,
    required this.artist,
    required this.imgURL,
    required this.explicit,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      artist: json['artists'][0][
          'name'], // TODO: if there are multiple artists, this only returns the first one
      imgURL: json['album']['images'][1]
          ['url'], // index 0 = 640x640, index 1 = 300x300, index 2 = 64x64
      explicit: json['explicit'],
    );
  }
}

Future<List<Track>> searchSongs(String query) async {
  const List<String> _filterWords = ["night"];
  const int _numSongsToQuery = 20; // how many songs to request per call
  final authorizationEndpoint =
      Uri.parse("https://accounts.spotify.com/api/token");
  final clientID = "d7e415d5343f47f5aa3d5fc03ae3e3d3";
  final clientSecret = "e9121896ded14c54b842241db14735a8";
  final client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, clientID, clientSecret);
  final authToken = client.credentials.accessToken;
  final queryEncoded = Uri.encodeComponent(query);
  final response = await http.get(
    Uri.parse(
      "https://api.spotify.com/v1/search?q=$queryEncoded&type=track&limit=$_numSongsToQuery",
    ),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
  final responseJson = jsonDecode(response.body);
  List<Track> songs = [];
  (responseJson['tracks']['items'] as List<dynamic>).forEach((json) {
    Track song = Track.fromJson(json);
    bool cleanTitle = true;
    _filterWords.forEach((invalidWord) {
      if (song.name.toLowerCase().contains(invalidWord)) {
        cleanTitle = false;
      }
    });
    if (cleanTitle) songs.add(song);
  });
  if (songs.length <= 5) {
    return songs;
  } else {
    return songs.sublist(0, 5);
  }
}
