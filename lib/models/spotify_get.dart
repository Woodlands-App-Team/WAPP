import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wapp/models/filter_words.dart';

class Track {
  final String name;
  final String artist;
  final String imgURL;
  final bool explicit;
  final String songURL;

  Track({
    required this.name,
    required this.artist,
    required this.imgURL,
    required this.explicit,
    required this.songURL,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      artist: json['artists'][0]['name'],
      // TODO: if there are multiple artists, this only returns the first one
      imgURL: json['album']['images'][1]['url'],
      // index 0 = 640x640, index 1 = 300x300, index 2 = 64x64
      explicit: json['explicit'],
      songURL: json['external_urls']['spotify'],
    );
  }
}

Future<String> getToken() async {
  final authorizationEndpoint =
      Uri.parse("https://accounts.spotify.com/api/token");
  final clientID = "d7e415d5343f47f5aa3d5fc03ae3e3d3";
  final clientSecret = "e9121896ded14c54b842241db14735a8";
  final client = await oauth2.clientCredentialsGrant(
    authorizationEndpoint,
    clientID,
    clientSecret,
  );
  return client.credentials.accessToken;
}

Future<http.Response> searchSpotify(String query, String authToken) async {
  const int _numSongsToQuery = 20; // how many songs to request per call
  final queryEncoded = Uri.encodeComponent(query);
  final response = await http.get(
    Uri.parse(
      "https://api.spotify.com/v1/search?q=$queryEncoded&type=track&limit=$_numSongsToQuery",
    ),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
  return response;
}

Future<http.Response> searchPlaylist(String authToken) async {
  final response = await http.get(
    Uri.parse(
      "https://api.spotify.com/v1/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks?market=CA",
    ),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + authToken,
    },
  );
  return response;
}

Future<List<Track>> parseJson(http.Response response) async {
  final responseJson = jsonDecode(response.body);
  List<Track> songs = [];
  (responseJson['tracks']['items'] as List<dynamic>).forEach((json) {
    Track song = Track.fromJson(json);
    bool cleanTitle = true;
    filterWords.forEach((invalidWord) {
      if (song.name.toLowerCase().contains(invalidWord)) {
        cleanTitle = false;
      }
    });
    if (cleanTitle) songs.add(song);
  });
  return songs;
}

Future<List<Track>> parseJsonPlaylist(http.Response response) async {
  const List<String> _filterWords = ["night"];
  List<Track> songs = [];
  final responseJson = jsonDecode(response.body);
  (responseJson['items'] as List<dynamic>).forEach((track) {
    Track song = Track.fromJson(track['track']);
    bool cleanTitle = true;
    _filterWords.forEach((invalidWord) {
      if (song.name.toLowerCase().contains(invalidWord)) {
        cleanTitle = false;
      }
    });
    if (cleanTitle) songs.add(song);
  });
  return songs;
}

Future<List<Track>> topTracks() async {
  final prefs = await SharedPreferences.getInstance();
  final authToken = prefs.getString('token') ?? '';
  final response = await searchPlaylist(authToken);
  if (response.statusCode == 200) {
    final List<Track> songs = await parseJsonPlaylist(response);
    return songs.sublist(0, 20);
  } else {
    final authToken2 = await getToken();
    final response2 = await searchPlaylist(authToken2);
    if (response2.statusCode == 200) {
      prefs.setString('token', authToken2);
      final List<Track> songs = await parseJsonPlaylist(response2);
      return songs.sublist(0, 20);
    } else {
      print(response2.statusCode);
      return [];
    }
  }
}

Future<List<Track>> searchSongs(String query) async {
  final prefs = await SharedPreferences.getInstance();
  final authToken = prefs.getString('token') ?? '';
  final response = await searchSpotify(query, authToken);
  if (response.statusCode == 200) {
    final List<Track> songs = await parseJson(response);
    return songs;
  } else {
    final authToken2 = await getToken();
    final response2 = await searchSpotify(query, authToken2);
    if (response2.statusCode == 200) {
      prefs.setString('token', authToken2);
      final List<Track> songs = await parseJson(response2);
      return songs;
    } else {
      return [];
    }
  }
}
