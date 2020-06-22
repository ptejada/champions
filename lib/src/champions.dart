import 'store.dart';
import 'enums.dart';

typedef ChampionFilter = bool Function(Champion champ);

/// Champions factory
class Champions {
  Map<String, Champion> list = {};

  /// Get all champions
  Future<Map<String, Champion>> all() async {
    if (list.isEmpty) {
      var store = await globalStore();
      var data = await store.document('champion').fetch();

      data['data'].forEach((name, data) => list[name] = Champion(data));
    }

    return list;
  }

  /// Filter the champion list
  Future<Iterable<Champion>> filter(ChampionFilter filter) async {
    final list = await all();
    return list.values.where(filter);
  }

  /// Search champions by name
  Future<Iterable<Champion>> search(String name) {
    return filter((champ) => champ.name.contains(name));
  }

  /// Gets list of champions by role
  Future<Iterable<Champion>> withRole(Role role) {
    return filter((champ) => champ.roles.contains(role));
  }
}

class Champion {
  final String id;
  final int key;
  final String name;
  final String title;
  final List<Role> roles;
  final ChampionStat stat;
  final _Image icon;

  Champion(Map data)
      : id = data['id'],
        key = int.parse(data['key']),
        name = data['name'],
        title = data['title'],
        roles = data['tags'].map<Role>((tag) => Role.fromString(tag)).toList(),
        stat = ChampionStat(data['stats']),
        icon = _Image(data['image']);
}

class ChampionStat {
  final Map<String, double> _stat;

  ChampionStat(Map data) : _stat = data.cast<String, double>();
}

class _Image {
  final String _fullName;
  final String _folder;
  final String _spriteName;
  final int _spriteX;
  final int _spriteWidth;

  String get url {
    return '';
  }

  String get spriteUrl {
    return '';
  }

  _Image(Map image)
      : _fullName = image['full'],
        _folder = image['group'],
        _spriteName = image['sprite'],
        _spriteX = image['x'],
        _spriteWidth = image['w'];
}
