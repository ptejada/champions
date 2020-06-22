import 'package:champions/src/champions.dart';
import 'package:champions/src/enums.dart';
import 'package:test/test.dart';

void main() {
  group('Champions factory test', () {
    Champions champions;

    setUp(() {
      champions = Champions();
    });

    test('Getting all champions', () async {
      var all = await champions.all();
      expect(all.length, greaterThan(100));
      expect(all, contains('Veigar'));
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
