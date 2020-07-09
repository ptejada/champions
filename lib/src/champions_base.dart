import 'package:champions/storage.dart';

import 'enums.dart';
import 'champion_api.dart' as api;
import 'asset_api.dart' as api;
import 'utils.dart';

/// The Champion factory class
class Champions {
  final Map<String, api.Champion> _list = <String, Champion>{};
  final Store _store;

  /// Creates champion factory with an specific store
  Champions([this._store = const Store()]);

  /// Creates [Champions] class with the latest patch and default language for a
  /// [Region]
  static Future<Champions> forRegion([Region region = Region.na]) async {
    final store = await Store.forRegion(region);

    return Champions(store);
  }

  /// A lis of all champions index by code name
  Future<Map<String, api.Champion>> get all async {
    if (_list.isEmpty) {
      var data = await _store.document('champion').fetch();

      data['data']
          .forEach((name, data) => _list[name] = Champion(data, _store));
    }

    return _list;
  }

  /// Filter the champion list
  Future<Iterable<api.Champion>> filter(api.ChampionFilter filter) async {
    return all.then((list) => list.values.where(filter));
  }

  /// Search champions by name
  Future<Iterable<api.Champion>> search(String name) {
    return filter((champ) => champ.name.contains(name));
  }

  /// Gets list of champions by role
  Future<Iterable<api.Champion>> withRole(Role role) {
    return filter((champ) => champ.roles.contains(role));
  }

  /// Get a champion by id
  Future<api.Champion> champion(String id) async {
    final list = await all;
    if (list.containsKey(id)) {
      return list[id];
    }

    return null;
  }
}

class Champion implements api.Champion {
  @override
  final String id;
  @override
  final int key;
  @override
  final String name;
  @override
  final String title;
  @override
  final String blurb;
  @override
  final int difficulty;
  @override
  final AbilityResource resource;
  @override
  final List<Role> roles;
  @override
  final api.ChampionStats stats;
  @override
  final ImageIcon icon;

  final ExtraChampionInfo _extra;

  @override
  Future<String> get lore => _extra.get('lore');

  @override
  Future<String> get allyTips => _extra.get('allytips');

  @override
  Future<String> get enemyTips => _extra.get('enemytips');

  @override
  Future<Iterable<ChampionSkin>> get skins async {
    var skins = await _extra.get('skins');

    if (skins is Iterable) {
      return skins.map((skin) => ChampionSkin(
            champId: id,
            id: skin['id'],
            name: skin['name'],
            hasChroma: skin['chromas'],
            num: skin['num'],
            store: _extra.store,
          ));
    }

    return <ChampionSkin>[];
  }

  Champion(Map data, Store store)
      : id = data['id'],
        key = int.parse(data['key']),
        name = data['name'],
        title = data['title'],
        blurb = data['blurb'],
        difficulty = data['info']['difficulty'],
        resource = enumFromString<AbilityResource>(
            AbilityResource.values, data['partype']),
        roles = data['tags']
            .map<Role>((tag) => enumFromString(Role.values, tag))
            .toList(),
        stats = ChampionStats(data['stats']),
        icon = ImageIcon(data['image'], store),
        _extra = ExtraChampionInfo(data['id'], store);
}

class ChampionSkin implements api.ChampionSkin {
  @override
  final String id;
  @override
  final String name;
  @override
  final bool hasChroma;
  @override
  final int num;
  final Store store;
  final String _champId;

  @override
  Image get full => Image(store.image('champion/splash/$_champId', 'jpg'));

  @override
  Image get compact => Image(store.image('champion/loading/$_champId', 'jpg'));

  ChampionSkin(
      {this.id, this.name, this.hasChroma, this.num, this.store, champId})
      : _champId = champId;
}

class ExtraChampionInfo {
  final String _id;

  final Store store;

  Map _data;

  ExtraChampionInfo(this._id, this.store);

  Future get(String propName) async {
    if (_data == null) {
      await store
          .document('champion/$_id')
          .fetch()
          .then((data) => _data = data['data'][_id]);
    }

    return _data[propName];
  }
}

/// Base champion stats
class LevelStats implements api.LevelStats {
  final Map _stat;
  final num level;

  LevelStats(this._stat, [level = 0]): level = level > 1 ? level : 0;

  @override
  num get hp => _stat['hp'] + (level * _stat['hpperlevel']);

  @override
  num get hpRegen => _stat['hpregen'] + (level * _stat['hpregenperlevel']);

  @override
  num get mana => _stat['mp'] + (level * _stat['mpperlevel']);

  @override
  num get manaRegen => _stat['mpregen'] + (level * _stat['mpregenperlevel']);

  @override
  num get movementSpeed => _stat['movespeed'];

  @override
  num get magicResist =>
      _stat['spellblock'] + (level * _stat['spellblockperlevel']);

  @override
  num get armor => _stat['armor'] + (level * _stat['armorperlevel']);

  @override
  num get crit => _stat['crit'] + (level * _stat['critperlevel']);

  @override
  num get attackDamage =>
      _stat['attackdamage'] + (level * _stat['attackdamageperlevel']);

  @override
  num get attackRange => _stat['attackrange'];

  @override
  num get attackSpeed =>
      _stat['attackspeed'] + (level * _stat['attackspeedperlevel']);
}

/// The champion stats
class ChampionStats extends LevelStats implements api.ChampionStats {
  ChampionStats(Map data) : super(data.cast<String, num>());

  /// Generates champion stats at the specified level
  api.LevelStats atLevel(int level) => LevelStats(_stat, level);
}

class Image implements api.Image {
  @override
  final String url;

  Image(Resource img) : url = img.url;
}

/// A reference to an image
class ImageIcon extends Image implements api.ImageIcon {
  final ImageSprite sprite;

  ImageIcon(Map image, Store _store)
      : sprite = ImageSprite(_store.image('sprite/${image['sprite']}'),
            x: image['x'],
            y: image['y'],
            width: image['w'],
            height: image['h']),
        super(_store.image("${image['group']}/${image['full']}"));
}

/// A reference for an image in a sprite
class ImageSprite implements api.ImageSprite {
  @override
  final int x;
  @override
  final int y;
  @override
  final int width;
  @override
  final int height;
  @override
  final String url;

  ImageSprite(Resource img, {this.x = 0, this.y = 0, this.height, this.width})
      : url = img.url;
}
