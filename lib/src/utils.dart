import 'package:champions/src/exceptions.dart';
import 'package:champions/src/item_enums.dart';
import 'package:enum_to_string/enum_to_string.dart';

/// Helper function to translate a string into an enum reference
T enumFromString<T>(List<T> values, String code, [T defaultEnum]) {
  final ref = EnumToString.fromString(values, code.replaceAll(' ', ''));

  if (ref != null) {
    return ref;
  }

  if (defaultEnum != null) {
    return defaultEnum;
  }

  final type = values.first.toString().split('.').first;

  throw EnumException<T>('The $type code $code is not supported.');
}

const _ItemStatNames = {
  'FlatHPPoolMod': ItemStat.hp,
  'FlatHPRegenMod': ItemStat.hpRegen,
  'FlatMPPoolMod': ItemStat.mana,
  // TODO: Determine how calculate the mana regen
  '': ItemStat.manaRegen,
  'FlatMovementSpeedMod': ItemStat.movementSpeed,
  'PercentMovementSpeedMod': ItemStat.movementSpeed,
  'FlatCritChanceMod': ItemStat.critChance,
  'FlatMagicDamageMod': ItemStat.magicDamage,
  'FlatArmorMod': ItemStat.armor,
  'FlatSpellBlockMod': ItemStat.magicResist,
  'FlatPhysicalDamageMod': ItemStat.attackDamage,
  'PercentAttackSpeedMod': ItemStat.attackSpeed,
  'PercentLifeStealMod': ItemStat.lifeSteal,
};

/// Helper function to build a list of item stats
Map<ItemStat, num> buildItemStats(Map data) {
  var list = <ItemStat, num>{};

  data.forEach((key, value) {
    if (_ItemStatNames.containsKey(key)) {
      list[_ItemStatNames[key]] = value;
    }
  });

  return list;
}

const _ItemTagNames = {
  'Boots': Tag.boots,
  'ManaRegen': Tag.manaRegen,
  'HealthRegen': Tag.healthRegen,
  'Health': Tag.health,
  'CriticalStrike': Tag.criticalStrike,
  'SpellDamage': Tag.spellDamage,
  'Mana': Tag.mana,
  'Armor': Tag.armor,
  'SpellBlock': Tag.magicResist,
  'Damage': Tag.damage,
  'Lane': Tag.lane,
  'LifeSteal': Tag.lifeSteal,
  'OnHit': Tag.onHit,
  'Jungle': Tag.jungle,
  'AttackSpeed': Tag.attackSpeed,
  'Consumable': Tag.consumable,
  'Active': Tag.active,
  'Stealth': Tag.stealth,
  'Vision': Tag.vision,
  'CooldownReduction': Tag.cooldownReduction,
  'NonbootsMovement': Tag.nonBootsMovement,
  'Tenacity': Tag.tenacity,
  'SpellVamp': Tag.spellVamp,
  'Aura': Tag.aura,
  'MagicPenetration': Tag.magicPenetration,
  'Slow': Tag.slow,
  'ArmorPenetration': Tag.armorPenetration,
  'Trinket': Tag.trinket,
  'GoldPer': Tag.generatesGold,
  'Bilgewater': Tag.bilgeWater,
};

/// Helper function to build a list of item tags
List<Tag> buildItemTags(Iterable data) {
  var list = <Tag>[];

  for (var tag in data) {
    if (_ItemTagNames.containsKey(tag)) {
      list.add(_ItemTagNames[tag]);
    }
  }

  return list;
}
