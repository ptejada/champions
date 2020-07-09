import 'enums.dart';
import 'asset_api.dart';

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
  final Future<String> allyTips;

  /// Tips for enemies
  final Future<String> enemyTips;

  /// A list of all the champion skins
  final Future<Iterable<ChampionSkin>> skins;

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
      this.skins);
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
