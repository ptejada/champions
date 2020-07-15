import 'enums.dart';
import 'api_assets.dart';

/// Callback to filter the champion list
typedef ChampionFilter = bool Function(Champion champ);

/// A champion reference.
///
/// To create an instance for an specific champion use the factory
abstract class Champion {
  /// The unique code name
  final String id;

  /// The unique numeric id
  final int key;

  /// The display name
  final String name;

  /// The title or tagline
  final String title;

  /// A blurb or excerpt of the full lore
  final String blurb;

  /// The difficulty level
  /// TODO: Make this an enum of three different  levels
  final int difficulty;

  /// The resource used for the spell or abilities
  final AbilityResource resource;

  /// List of champion roles
  final List<Role> roles;

  /// The champion stats info
  final ChampionStats stats;

  /// The square champion image icon
  final ImageIcon icon;

  /// The full champion lore
  final Future<String> lore;

  /// Tips for allies
  final Future<Iterable<String>> allyTips;

  /// Tips for enemies
  final Future<Iterable<String>> enemyTips;

  /// A list of all the champion skins
  final Future<Iterable<ChampionSkin>> skins;

  /// A list of all champion spells
  final Future<Iterable<ChampionSpell>> spells;

  /// Tha champion passive
  final Future<ChampionPassive> passive;

  Champion._(
      this.id,
      this.key,
      this.name,
      this.title,
      this.blurb,
      this.difficulty,
      this.resource,
      this.roles,
      this.stats,
      this.icon,
      this.lore,
      this.allyTips,
      this.enemyTips,
      this.skins,
      this.spells,
      this.passive);
}

/// A champion skin
abstract class ChampionSkin {
  /// The unique global skin id
  final String id;

  /// The skin display name
  final String name;

  /// Whether the skin has chromas
  final bool hasChroma;

  /// The unique champion level skin id
  final int num;

  /// The big splash image version of the skin
  final Image full;

  /// The compact tall rectangular version of the skin used in the match
  /// loading screen
  final Image compact;

  ChampionSkin._(
      this.id, this.name, this.hasChroma, this.num, this.full, this.compact);
}

/// The champion stats at an specific level
abstract class LevelStats {
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

  LevelStats._(
      this.hp,
      this.hpRegen,
      this.mana,
      this.manaRegen,
      this.movementSpeed,
      this.magicResist,
      this.armor,
      this.crit,
      this.attackDamage,
      this.attackRange,
      this.attackSpeed);
}

/// The champion based stats
abstract class ChampionStats extends LevelStats {
  ChampionStats._(hp, hpRegen, mana, manaRegen, movementSpeed, magicResist,
      armor, crit, attackDamage, attackRange, attackSpeed)
      : super._(hp, hpRegen, mana, manaRegen, movementSpeed, magicResist, armor,
            crit, attackDamage, attackRange, attackSpeed);

  /// Generates champion stats at the specified level
  LevelStats atLevel(int level);
}

abstract class ChampionPassive {
  /// The passive display name
  final String name;

  /// The passive description
  final String description;

  /// The passive icon image
  final ImageIcon icon;

  ChampionPassive._(this.name, this.description, this.icon);
}

abstract class ChampionSpell {
  /// The unique champion spell id
  final String id;

  /// The spell display name
  final String name;

  /// The spell description
  final String description;

  /// The spell description with specific stats
  final String tooltip;

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

  /// The ability video clip
  final VideoClip clip;

  /// The spell key
  final String key;

  ChampionSpell._(this.id, this.name, this.description, this.tooltip,
      this.cooldown, this.cost, this.range, this.maxRank, this.icon, this.clip, this.key);
}

abstract class SpellCooldown {
  /// The level of the cooldown
  final int amount;

  /// All the cooldown spread by rank in single string
  ///
  /// Ex: 10/8/6/4
  /// Means 10 seconds at rank 1, 8 seconds at rank 2 and so on
  final String spread;

  SpellCooldown._(this.amount, this.spread);

  /// The cooldown at an specific rank
  int atRank(int rank);

  @override
  String toString();
}

abstract class SpellCost {
  /// The level of the cooldown
  final int amount;

  /// All the resource cost spread by rank in a single string
  ///
  /// Ex: 60/80/90
  /// Means it costs 60 resource points at rank 1, 80 points at rank 2 and so on
  final String spread;

  SpellCost._(this.amount, this.spread);

  /// The cooldown at an specific rank
  int atRank(int rank);

  @override
  String toString();
}

abstract class SpellRange {
  /// The spell range
  final int amount;

  /// All the spell rage spread by rank in a single string
  ///
  /// Ex: 100/150/200
  /// Means the range is 100 units at rank 1, 150 units at rank 2 and so on
  final String spread;

  SpellRange._(this.amount, this.spread);

  /// The range at an specific rank
  int atRank(int rank);

  @override
  String toString();
}
