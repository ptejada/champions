import 'package:champions/storage.dart';

import 'champions_base.dart';
import 'api_champion.dart' as api;
import 'api_assets.dart' as api;

final _cdnUrl = 'https://d28xe8vt774jo5.cloudfront.net';

class Spell implements api.ChampionSpell {
  /// The unique champion spell id
  @override
  final String id;

  /// The spell display name
  @override
  final String name;

  /// The spell description
  @override
  final String description;

  /// The spell cooldown
  @override
  final SpellCooldown cooldown;

  /// The spell cost
  @override
  final SpellCost cost;

  /// The spell range and in units
  @override
  final SpellRange range;

  /// The maximum rank the spell can be level up
  @override
  final int maxRank;

  /// The ability icon
  @override
  final ImageIcon icon;

  final String _rawTooltip;

  /// The unique champion key
  final int _champKey;

  /// The ability key
  @override
  final String key;

  Spell(Map data, this.key, this._champKey, Store store)
      : id = data['id'],
        name = data['name'],
        description = data['description'],
        maxRank = data['maxrank'],
        _rawTooltip = data['tooltip'],
        cost = SpellCost(data),
        range = SpellRange(data),
        cooldown = SpellCooldown(data),
        icon = ImageIcon(data['image'], store);

  @override
  // TODO: Parse the tooltip placeholders?
  String get tooltip => _rawTooltip;

  @override
  api.VideoClip get clip {
    // Example URL where 0266 is the champion key left padded with 0 up to 4
    // characters and E is the spell keyboard key
    // https://d28xe8vt774jo5.cloudfront.net/champion-abilities/0266/ability_0266_E1.webm

    var champId = _champKey.toString().padLeft(4, '0');
    var urlPath = '$_cdnUrl/champion-abilities/$champId/'
        'ability_${champId}_${key}1';

    return VideoClip('${urlPath}.webm', '${urlPath}.jpg');
  }
}

class VideoClip implements api.VideoClip {
  @override
  final String url;
  @override
  final api.Image thumbnail;

  VideoClip(this.url, String thumbnailUrl)
      : thumbnail = VideoImage(thumbnailUrl);
}

class VideoImage implements api.Image {
  @override
  final String url;

  VideoImage(this.url);
}

class SpellStat {
  final Iterable<num> _list;
  final String spread;

  int get amount => _list.first;

  int atRank(int rank) {
    var index = rank - 1;
    if (index < 0) {
      return _list.first;
    }

    if (index > _list.length) {
      return _list.last;
    }

    return _list.elementAt(index);
  }

  SpellStat(Iterable list, this.spread) : _list = List.from(list);

  @override
  String toString() {
    return '$amount';
  }
}

class SpellRange extends SpellStat implements api.SpellRange {
  SpellRange(Map data) : super(data['range'], data['rangeBurn']);
}

class SpellCost extends SpellStat implements api.SpellCost {
  SpellCost(Map data) : super(data['cost'], data['costBurn']);
}

class SpellCooldown extends SpellStat implements api.SpellCooldown {
  SpellCooldown(Map data) : super(data['cooldown'], data['cooldownBurn']);
}

class Passive implements api.ChampionPassive {
  @override
  final String name;
  @override
  final String description;
  @override
  final api.ImageIcon icon;

  Passive(Map data, Store store)
      : name = data['name'],
        description = data['description'],
        icon = ImageIcon(data['image'], store);
}
