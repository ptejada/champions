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
      expect(champ.stat.mana.round(), 418);
      expect(champ.stat.hp, greaterThanOrEqualTo(0));
      expect(champ.stat.hpRegen, greaterThanOrEqualTo(0));
      expect(champ.stat.mana, greaterThanOrEqualTo(0));
      expect(champ.stat.manaRegen, greaterThanOrEqualTo(0));
      expect(champ.stat.movementSpeed, greaterThanOrEqualTo(0));
      expect(champ.stat.magicResist, greaterThanOrEqualTo(0));
      expect(champ.stat.armor, greaterThanOrEqualTo(0));
      expect(champ.stat.crit, greaterThanOrEqualTo(0));
      expect(champ.stat.attackDamage, greaterThanOrEqualTo(0));
      expect(champ.stat.attackRange, greaterThanOrEqualTo(0));
      expect(champ.stat.attackSpeed, greaterThanOrEqualTo(0));

      var statsAtLevel = champ.stat.atLevel(5);

      expect(statsAtLevel.hp, equals(986));
      expect(statsAtLevel.hpRegen, equals(9.5));
      expect(statsAtLevel.mana, equals(543));
      expect(statsAtLevel.manaRegen, equals(12));
      expect(statsAtLevel.magicResist, equals(32.5));
      expect(statsAtLevel.armor.round(), equals(38));
      expect(statsAtLevel.attackDamage.round(), equals(68));
      expect(statsAtLevel.attackSpeed, equals(10.668));
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
