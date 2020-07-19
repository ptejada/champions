import 'package:champions/items.dart';
import 'package:champions/src/api_item.dart';
import 'package:champions/src/item_enums.dart';
import 'package:test/test.dart';

void main() {
  group('Items factory', () {
    Items items;

    setUp(() {
      items = Items();
    });

    test('Get all items', () async {
      var all = await items.all;

      expect(all.length, greaterThan(230));
    });

    test('Get all items for the Rift store', () async {
      var all = await items.inRiftStore;

      expect(all.length, lessThan(230));
    });

    test('Access all public properties with getters', () async {
      var all = await items.all;

      for (var item in all.values) {
        expect(item.tags, isA<Iterable<Tag>>());
        expect(item.maps, isA<Iterable<GameMap>>());
        expect(item.stats, isA<Map<ItemStat, num>>());
        expect(await item.buildsInto, isA<Iterable<Item>>());
        expect(await item.buildsFrom, isA<Iterable<Item>>());
      }
    });
  });
}
