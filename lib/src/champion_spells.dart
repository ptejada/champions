import 'package:champions/storage.dart';

import 'champions_base.dart';
import 'champion_api.dart' as api;
import 'asset_api.dart' as api;

class Spell implements api.ChampionSpell {
  /// The unique champion spell id
  final String id;

  /// The spell display name
  final String name;

  /// The spell description
  final String description;

  /// The spell cooldown
  final SpellCooldown cooldown;

  /// The spell cost
  final SpellCost cost;

  /// The spell range and in units
  final SpellRange range;

  /// The maximum rank the spell can be level up
  final int maxRank;

  /// The ability icon
  final ImageIcon icon;

  final String _rawTooltip;

  Spell(Map data, Store store)
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
}

class SpellStat {
  final Iterable<int> _list;
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
