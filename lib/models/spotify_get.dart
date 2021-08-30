import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';

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
  const List<String> _filterWords = [
    '2g1c',
    '2 girls 1 cup',
    'acrotomophilia',
    'alabama hot pocket',
    'alaskan pipeline',
    'anal',
    'anilingus',
    'anus',
    'apeshit',
    'arsehole',
    'ass',
    'asshole',
    'assmunch',
    'auto erotic',
    'autoerotic',
    'babeland',
    'baby batter',
    'baby juice',
    'ball gag',
    'ball gravy',
    'ball kicking',
    'ball licking',
    'ball sack',
    'ball sucking',
    'bangbros',
    'bareback',
    'barely legal',
    'barenaked',
    'bastard',
    'bastardo',
    'bastinado',
    'bbw',
    'bdsm',
    'beaner',
    'beaners',
    'beaver cleaver',
    'beaver lips',
    'bestiality',
    'big black',
    'big breasts',
    'big knockers',
    'big tits',
    'bimbos',
    'birdlock',
    'bitch',
    'bitches',
    'black cock',
    'blonde action',
    'blonde on blonde action',
    'blowjob',
    'blow job',
    'blow your load',
    'blue waffle',
    'blumpkin',
    'bollocks',
    'bondage',
    'boner',
    'boob',
    'boobs',
    'booty call',
    'brown showers',
    'brunette action',
    'bukkake',
    'bulldyke',
    'bullet vibe',
    'bullshit',
    'bung hole',
    'bunghole',
    'busty',
    'butt',
    'buttcheeks',
    'butthole',
    'camel toe',
    'camgirl',
    'camslut',
    'camwhore',
    'carpet muncher',
    'carpetmuncher',
    'chocolate rosebuds',
    'circlejerk',
    'cleveland steamer',
    'clit',
    'clitoris',
    'clover clamps',
    'clusterfuck',
    'cock',
    'cocks',
    'coprolagnia',
    'coprophilia',
    'cornhole',
    'coon',
    'coons',
    'creampie',
    'cum',
    'cracker',
    'ligma',
    'sugma',
    'bofa',
    'cumming',
    'cunnilingus',
    'cunt',
    'darkie',
    'date rape',
    'daterape',
    'deep throat',
    'deepthroat',
    'dendrophilia',
    'dick',
    'dildo',
    'dingleberry',
    'dingleberries',
    'dirty pillows',
    'dirty sanchez',
    'doggie style',
    'doggiestyle',
    'doggy style',
    'doggystyle',
    'dog style',
    'dolcett',
    'domination',
    'dominatrix',
    'dommes',
    'donkey punch',
    'double dong',
    'double penetration',
    'dp action',
    'dry hump',
    'dvda',
    'eat my ass',
    'ecchi',
    'ejaculation',
    'erotic',
    'erotism',
    'escort',
    'eunuch',
    'faggot',
    'fecal',
    'felch',
    'fellatio',
    'feltch',
    'female squirting',
    'femdom',
    'figging',
    'fingerbang',
    'fingering',
    'fisting',
    'foot fetish',
    'footjob',
    'frotting',
    'fuck',
    'fuck buttons',
    'fuckin',
    'fucking',
    'fucktards',
    'fudge packer',
    'fudgepacker',
    'futanari',
    'gang bang',
    'gay sex',
    'genitals',
    'giant cock',
    'girl on',
    'girl ontop',
    'girls gone wild',
    'goatcx',
    'goatse',
    'god damn',
    'gokkun',
    'golden shower',
    'goodpoop',
    'goo girl',
    'goregasm',
    'grope',
    'group sex',
    'g-spot',
    'guro',
    'hand job',
    'handjob',
    'hard core',
    'hardcore',
    'hentai',
    'homoerotic',
    'honkey',
    'hooker',
    'hot carl',
    'hot chick',
    'how to kill',
    'how to murder',
    'huge fat',
    'humping',
    'incest',
    'intercourse',
    'jack off',
    'jail bait',
    'jailbait',
    'jelly donut',
    'jerk off',
    'jigaboo',
    'jiggaboo',
    'jiggerboo',
    'jizz',
    'juggs',
    'kike',
    'kinbaku',
    'kinkster',
    'kinky',
    'knobbing',
    'leather restraint',
    'leather straight jacket',
    'lemon party',
    'lolita',
    'lovemaking',
    'make me come',
    'male squirting',
    'masturbate',
    'menage a trois',
    'milf',
    'missionary position',
    'motherfucker',
    'mound of venus',
    'mr hands',
    'muff diver',
    'muffdiving',
    'nambla',
    'nawashi',
    'negro',
    'neonazi',
    'nigga',
    'nigr',
    'negger',
    'niga',
    'nigger',
    'nig nog',
    'nimphomania',
    'nipple',
    'nipples',
    'nsfw images',
    'nude',
    'nudity',
    'nympho',
    'nymphomania',
    'octopussy',
    'omorashi',
    'one cup two girls',
    'one guy one jar',
    'orgasm',
    'orgy',
    'paedophile',
    'paki',
    'panties',
    'panty',
    'pedobear',
    'pedophile',
    'pegging',
    'penis',
    'phone sex',
    'piece of shit',
    'pissing',
    'piss pig',
    'pisspig',
    'playboy',
    'pleasure chest',
    'pole smoker',
    'ponyplay',
    'poof',
    'poon',
    'poontang',
    'punany',
    'poop chute',
    'poopchute',
    'porn',
    'porno',
    'pornography',
    'prince albert piercing',
    'pthc',
    'pubes',
    'pussy',
    'queaf',
    'queef',
    'quim',
    'raghead',
    'raging boner',
    'rape',
    'raping',
    'rapist',
    'rectum',
    'reversecowgirl',
    'rimjob',
    'rimming',
    'rosy palm',
    'rosy palm and her 5 sisters',
    'rusty trombone',
    'sadism',
    'santorum',
    'scat',
    'schlong',
    'scissoring',
    'semen',
    'sex',
    'sexo',
    'sexy',
    'shaved beaver',
    'shaved pussy',
    'shemale',
    'shibari',
    'shit',
    'shitblimp',
    'shitty',
    'shota',
    'shrimping',
    'skeet',
    'slanteye',
    'slut',
    's&m',
    'smut',
    'snatch',
    'snowballing',
    'sodomize',
    'sodomy',
    'spic',
    'splooge',
    'splooge moose',
    'spooge',
    'spread legs',
    'spunk',
    'strap on',
    'strapon',
    'strappado',
    'strip club',
    'style doggy',
    'suck',
    'sucks',
    'suicide girls',
    'sultry women',
    'swastika',
    'swinger',
    'tainted love',
    'taste my',
    'tea bagging',
    'threesome',
    'throating',
    'tied up',
    'tight white',
    'tit',
    'tits',
    'titties',
    'titty',
    'tongue in a',
    'topless',
    'tosser',
    'towelhead',
    'tranny',
    'tribadism',
    'tub girl',
    'tubgirl',
    'tushy',
    'twat',
    'twink',
    'twinkie',
    'two girls one cup',
    'undressing',
    'upskirt',
    'urethra play',
    'urophilia',
    'vagina',
    'venus mound',
    'vibrator',
    'violet wand',
    'vorarephilia',
    'voyeur',
    'vulva',
    'wank',
    'wetback',
    'wet dream',
    'white power',
    'wrapping men',
    'wrinkled starfish',
    'xx',
    'xxx',
    'yaoi',
    'yellow showers',
    'yiffy',
    'zoophilia'
  ];
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
    print(response.statusCode);
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
    print("USING TOKEN: " + authToken);
    final List<Track> songs = await parseJson(response);
    return songs;
  } else {
    final authToken2 = await getToken();
    final response2 = await searchSpotify(query, authToken2);
    if (response2.statusCode == 200) {
      print("USING TOKEN: " + authToken2);
      prefs.setString('token', authToken2);
      final List<Track> songs = await parseJson(response2);
      return songs;
    } else {
      // return empty list if fails twice
      return [];
    }
  }
}
