/// The common game maps
enum GameMap { summonersRift, howlingAbyss }

const _MapCodes = {
  GameMap.summonersRift: '11',
  GameMap.howlingAbyss: '12',
};

const _MapLabels = {
  GameMap.summonersRift: "Summoner's Rift",
  GameMap.howlingAbyss: 'Howling Abyss',
};

/// Provides the code and label for [GameMap]
extension GameMapLabel on GameMap {
  String get code => _MapCodes[this];

  String get label => _MapLabels[this];
}

/// Item stat
enum ItemStat {
  hp,
  hpRegen,
  mana,
  manaRegen,
  movementSpeed,
  critChance,
  magicDamage,
  armor,
  magicResist,
  attackDamage,
  attackSpeed,
  lifeSteal,
}

const _ItemStatLabels = {
  ItemStat.hp: 'HP',
  ItemStat.hpRegen: 'HP Regeneration',
  ItemStat.mana: 'Mana',
  ItemStat.manaRegen: 'Mana Regeneration',
  ItemStat.movementSpeed: 'Movement Speed',
  ItemStat.critChance: 'Crit Chance',
  ItemStat.magicDamage: 'Magic Damage',
  ItemStat.armor: 'Armor',
  ItemStat.magicResist: 'Magic Resist',
  ItemStat.attackDamage: 'Attack Damage',
  ItemStat.attackSpeed: 'Attack Speed',
  ItemStat.lifeSteal: 'Life Steal',
};

/// Provides the label for [ItemStat]
extension ItemStatLabel on ItemStat {
  String get label => _ItemStatLabels[this];
}

/// Tags associated with items
enum Tag {
  boots,
  manaRegen,
  healthRegen,
  health,
  criticalStrike,
  spellDamage,
  mana,
  armor,
  magicResist,
  damage,
  lane,
  lifeSteal,
  onHit,
  jungle,
  attackSpeed,
  consumable,
  active,
  stealth,
  vision,
  cooldownReduction,
  nonBootsMovement,
  tenacity,
  spellVamp,
  aura,
  magicPenetration,
  slow,
  armorPenetration,
  trinket,
  generatesGold,
  bilgeWater,
}
