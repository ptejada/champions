import 'store.dart';
import 'enums.dart';

/// Callback to filter the champion list
typedef ChampionFilter = bool Function(Champion champ);

/// Champions factory
class Champions {
  Map<String, Champion> list = {};

  /// Get all champions
  Future<Map<String, Champion>> get all async {
    if (list.isEmpty) {
      var store = await globalStore();
      var data = await store.document('champion').fetch();

      data['data'].forEach((name, data) => list[name] = Champion(data));
    }

    return list;
  }

  /// Filter the champion list
  Future<Iterable<Champion>> filter(ChampionFilter filter) async {
    return all.then((list) => list.values.where(filter));
  }

  /// Search champions by name
  Future<Iterable<Champion>> search(String name) {
    return filter((champ) => champ.name.contains(name));
  }

  /// Gets list of champions by role
  Future<Iterable<Champion>> withRole(Role role) {
    return filter((champ) => champ.roles.contains(role));
  }

  /// Get a champion by id
  Future<Champion> champion(String id) async {
    final list = await all;
    if (list.containsKey(id)) {
      return list[id];
    }

    return null;
  }
}

/// The champion class
class Champion {
  final String id;
  final int key;
  final String name;
  final String title;
  final String blurb;
  final int difficulty;
  final AbilityResource resource;
  final List<Role> roles;
  final ChampionStats stat;
  final _Image icon;

  Champion(Map data)
      : id = data['id'],
        key = int.parse(data['key']),
        name = data['name'],
        title = data['title'],
        blurb = data['blurb'],
        difficulty = data['info']['difficulty'],
        resource = AbilityResource.fromString(data['partype']),
        roles = data['tags'].map<Role>((tag) => Role.fromString(tag)).toList(),
        stat = ChampionStats(data['stats']),
        icon = _Image(data['image']);
}

/// Base champion stats
class _Stats {
  /// Health points
  final num hp;
  /// Health points regeneration
  final num hpRegen;
  /// Mana points
  final num mana;
  /// Mana points regeneration
  final num manaRegen;
  /// Movement speed
  final num movementSpeed;
  /// Magic resist
  final num magicResist;
  /// Armor
  final num armor;
  /// Critical hit chance
  final num crit;
  /// Basic attack damage
  final num attackDamage;
  /// Basic attack range
  final num attackRange;
  /// Basic attack speed
  final num attackSpeed;

  _Stats(
      {this.hp,
      this.hpRegen,
      this.mana,
      this.manaRegen,
      this.movementSpeed,
      this.magicResist,
      this.armor,
      this.crit,
      this.attackDamage,
      this.attackRange,
      this.attackSpeed});
}

/// Champion stats
class ChampionStats implements _Stats {
  final Map<String, num> _stat;

  /// Health points
  @override
  num get hp => _stat['hp'];

  /// Health points regeneration
  @override
  num get hpRegen => _stat['hpregen'];

  /// Mana Points
  @override
  num get mana => _stat['mp'];

  /// Mana points regeneration
  @override
  num get manaRegen => _stat['mpregen'];

  /// Movement speed
  @override
  num get movementSpeed => _stat['movespeed'];

  /// Magic resist
  @override
  num get magicResist => _stat['spellblock'];

  /// Armor
  @override
  num get armor => _stat['armor'];

  /// Critical hit chance percent
  @override
  num get crit => _stat['crit'];

  /// Basic attack damage
  @override
  num get attackDamage => _stat['attackdamage'];

  /// Basic attack range
  @override
  num get attackRange => _stat['attackrange'];

  /// Basic attack speed
  @override
  num get attackSpeed => _stat['attackspeed'];

  ChampionStats(Map data) : _stat = data.cast<String, num>();

  /// Generates champion stats at the specified level
  _Stats atLevel(int level) {
    return _Stats(
      hp: hp + (level * _stat['hpperlevel']),
      hpRegen: hpRegen + (level * _stat['hpregenperlevel']),
      mana: mana + (level * _stat['mpperlevel']),
      manaRegen: manaRegen + (level * _stat['mpregenperlevel']),
      movementSpeed: movementSpeed,
      magicResist: magicResist + (level * _stat['spellblockperlevel']),
      armor: armor + (level * _stat['armorperlevel']),
      crit: crit + (level * _stat['critperlevel']),
      attackDamage: attackDamage + (level * _stat['attackdamageperlevel']),
      attackRange: attackRange,
      attackSpeed: attackSpeed + (level * _stat['attackspeedperlevel']),
    );
  }
}

class _Image {
  final String _fullName;
  final String _folder;
  final String _spriteName;
  final int spriteX;
  final int spriteY;
  final int spriteWidth;
  final int spriteHeight;

  Future<String> get url async {
    var store = await globalStore();
    return store.image('$_folder/$_fullName').url;
  }

  Future<String> get spriteUrl async {
    var store = await globalStore();
    return store.image('sprite/$_spriteName').url;
  }

  _Image(Map image)
      : _fullName = image['full'],
        _folder = image['group'],
        _spriteName = image['sprite'],
        spriteX = image['x'],
        spriteY = image['y'],
        spriteWidth = image['w'],
        spriteHeight = image['h'];
}
