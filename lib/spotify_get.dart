import 'package:spotify/spotify.dart';

class SpotifySongApi {
  static const List<String> _filterWords = ["night"];
  static const int _numSongsToQuery = 20; // how many songs to request per call
  static Future<List<Track>> getTracks(String query) async {
    List<Track> songs = [];
    const String clientId = "b6c2ffeefbdf43568a62fea438e07a1c";
    const String clientSecret = "ec003fe62ee7495d90fcca1553b59361";
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
