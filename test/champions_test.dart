import 'package:champions/src/champions_base.dart';
import 'package:champions/src/enums.dart';
import 'package:test/test.dart';

void main() {
  group('Champions factory test', () {
    Champions champions;

    setUp(() {
      champions = Champions();
    });

    test('Getting all champions', () async {
      var all = await champions.all;
      expect(all.length, greaterThan(100));
      expect(all, contains('Veigar'));
    });

    test('Get champion by id', () async {
      var champ = await champions.champion('Veigar');
      expect(champ, isA<Champion>());
      expect(champ.id, equals('Veigar'));
    });

    test('Champion icon', () async {
      var champ = await champions.champion('Veigar');

      expect(await champ.icon.url, endsWith('img/champion/Veigar.png'));
      expect(await champ.icon.sprite.url, endsWith('img/sprite/champion4.png'));
    });

    test('Champion stat generator', () async {
      var champ = await champions.champion('Ahri');
      expect(champ, isA<Champion>());
      expect(champ.stats.mana.round(), 418);
      expect(champ.stats.hp, greaterThanOrEqualTo(0));
      expect(champ.stats.hpRegen, greaterThanOrEqualTo(0));
      expect(champ.stats.mana, greaterThanOrEqualTo(0));
      expect(champ.stats.manaRegen, greaterThanOrEqualTo(0));
      expect(champ.stats.movementSpeed, greaterThanOrEqualTo(0));
      expect(champ.stats.magicResist, greaterThanOrEqualTo(0));
      expect(champ.stats.armor, greaterThanOrEqualTo(0));
      expect(champ.stats.crit, greaterThanOrEqualTo(0));
      expect(champ.stats.attackDamage, greaterThanOrEqualTo(0));
      expect(champ.stats.attackRange, greaterThanOrEqualTo(0));
      expect(champ.stats.attackSpeed, greaterThanOrEqualTo(0));

      var statsAtLevel = champ.stats.atLevel(5);

      expect(statsAtLevel.hp, equals(986));
      expect(statsAtLevel.hpRegen, equals(9.5));
      expect(statsAtLevel.mana, equals(543));
      expect(statsAtLevel.manaRegen, equals(12));
      expect(statsAtLevel.magicResist, equals(32.5));
      expect(statsAtLevel.armor.round(), equals(38));
      expect(statsAtLevel.attackDamage.round(), equals(68));
      expect(statsAtLevel.attackSpeed, equals(10.668));
    });

    test('Champion spells', () async {
        var champ = await champions.champion('Ahri');
        var spells = await champ.spells;
        var spell = spells.first;

        expect(spell.name, equals('Orb of Deception'));
        expect(spell.description, contains('sends out and pulls back her orb'));
        expect(spell.cost.spread, contains('/'));
        expect(spell.cooldown.amount, greaterThan(5));
        expect(spell.icon.url, endsWith('.png'));
    });
  });

  group('Champions filter', () {
    var roles = [
      Role.support,
      Role.tank,
      Role.assassin,
      Role.fighter,
      Role.mage,
      Role.marksman
    ];

    var champions = Champions();

    for (var role in roles) {
      test('Champions filtered by $role', () async {
        var list = await champions.withRole(role);
        list.forEach((champ) => expect(champ.roles, contains(role)));
      });
    }

    test('Searching for champions', () async {
      var all = await champions.search('ve');

      all.forEach((champ) => expect(champ.name, contains('ve')));
    });
  });
}
