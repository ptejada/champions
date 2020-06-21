import 'dart:convert';
import 'dart:io';

const _baseUrl = 'http://ddragon.leagueoflegends.com/cdn';
const _version = '10.11.1';
const _region  = 'en_US';

_makeUrl(String document) {
  return "$_baseUrl/$_version/$document";
}

class Champion {
  final String id;
  final int key;
  final String name;
  final String title;
  final List<String> tags;
  final ChampionStat stat;
  final _Image icon;

  Champion(Map data):
      id = data['id'],
      key = int.parse(data['key']),
      name = data['name'],
      title = data['title'],
      tags = List<String>.from(data['tags']),
      stat = ChampionStat(data['stats']),
      icon = _Image(data['image']);

  static Iterable<Champion> collection(Map<String, Map> data) {
    return data.values.map<Champion>((champ) => Champion(champ));
  }

  /*
  static Stream<Champion> list() async* {
    String fileUrl = _makeUrl('data/$_region/champion.json');

    var file = await DefaultCacheManager().getSingleFile(fileUrl);

    String rawJson = await file.readAsString();
    var data = jsonDecode(rawJson);

    Iterable list = data['data'].values;

    for(var champ in list) {
      yield Champion(champ);
    }
  }
   */
}

  /*
class Champions {
  final String region;
  final String jsonUrl;

  Iterable<Champion> champions;

  Champions({String region = _region}):
      region = region ?? _region,
      jsonUrl = _makeUrl('data/$region/champion.json') {
    list();
  }

  Future<Iterable> list() async {
    if (champions == null) {
      await _refresh();
    }

    return champions;
  }

  void _refresh() async {
    champions = null;

    var file = await DefaultCacheManager().getSingleFile(jsonUrl);

    String rawJson = await file.readAsString();
    var data = jsonDecode(rawJson);

    Iterable list = data['data'].values;

    champions = list.map((item) => Champion(item));
  }
}
   */



/// The Champion role
enum Role {assassin, fighter, mage, marksmen, support, tank}

class ChampionStat {
  final Map<String, double> _stat;
  ChampionStat(Map data):
    _stat = data.cast<String, double>();
}

class _Image {
  final String _fullName;
  final String _folder;
  final String _spriteName;
  final int _spriteX;
  final int _spriteWidth;

  String get url {
    return _makeUrl("img/$_folder/$_fullName");
  }

  String get spriteUrl {
    return _makeUrl("img/sprite/$_spriteName");
  }

  _Image(Map image):
      _fullName = image['full'],
      _folder = image['group'],
      _spriteName = image['sprite'],
      _spriteX = image['x'],
      _spriteWidth = image['w'];
}
