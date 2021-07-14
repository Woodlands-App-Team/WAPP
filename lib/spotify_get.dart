import 'package:spotify/spotify.dart';

class SpotifySongApi {
  static const List<String> _filterWords = ["night"];
  static const int _numSongsToQuery = 20; // how many songs to request per call
  static Future<List<Track>> getTracks(String query) async {
    List<Track> songs = [];
    const String clientId = "d7e415d5343f47f5aa3d5fc03ae3e3d3";
    const String clientSecret = "e9121896ded14c54b842241db14735a8";
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final spotify = SpotifyApi(credentials);
    // request 20, return top 5 titles that don't contain the bad words
    final search = await spotify.search.get(query).first(_numSongsToQuery);
    for (var item in search[3].items) {
      if (item is TrackSimple) {
        // search[3].items should only contain tracks
        final song = await spotify.tracks.get(item.id);
        bool cleanTitle = true;
        _filterWords.forEach((invalidWord) {
          if (song.name!.toLowerCase().contains(invalidWord)) {
            cleanTitle = false;
          }
        });
        if (cleanTitle) songs.add(song);
      } else {
        // remove this when we want to deploy the app,
        // although it should never reach this else
        assert(false);
      }
    }
    if (songs.length <= 5) {
      return songs;
    } else {
      return songs.sublist(0, 5);
    }
  }
}
