import 'package:champions/src/api_assets.dart' as api;
import 'package:champions/src/utils.dart';
import 'package:champions/storage.dart';
import './api_item.dart' as api;
import './champions_base.dart';
import 'item_enums.dart';

class Items {
  final Map<int, api.Item> _list = <int, api.Item>{};
  final Store store;

  /// Creates champion factory with an specific store
  Items([this.store = const Store()]);

  /// A lis of all items index by their unique id
  Future<Map<int, api.Item>> get all async {
    if (_list.isEmpty) {
      var data = await store.document('item').fetch();

      data['data'].forEach((idStr, data) {
        var id = int.parse(idStr);

        _list[id] = Item(id, data, this);
      });
    }

    return _list;
  }

  /// Get all items available in Summoner's Rift store
  Future<Iterable<api.Item>> get inRiftStore async {
    return filter(
        (item) => item.inStore && item.maps.contains(GameMap.summonersRift));
  }

  /// Filter the item list
  Future<Iterable<api.Item>> filter(api.ItemFilter filter) async {
    return all.then((list) => list.values.where(filter));
  }

  /// Search items by name
  Future<Iterable<api.Item>> search(String name) {
    return filter((champ) => champ.name.contains(name));
  }

  /// Get a item by id
  Future<api.Item> item(int id) async {
    var list = await all;

    if (list.containsKey(id)) {
      return list[id];
    }

    return null;
  }
}

Future<Iterable<api.Item>> buildItemList(Iterable items, Items factory) async {
  var list = <api.Item>[];

  if (items != null) {
    for (var id in items) {
      var item = await factory.item(int.parse(id));
      if (item != null) {
        list.add(item);
      }
    }
  }

  return list;
}

class Item implements api.Item {
  Item(this.id, Map data, Items items)
      : blurb = data['plaintext'],
        depth = data['depth'],
        description = data['description'],
        name = data['name'],
        icon = ImageIcon(data['image'], items.store),
        inStore = data.containsKey('inStore') ? data['inStore'] : true,
        price = Price(data['gold']),
        _factory = items,
        _extra = {
          'maps': data['maps'],
          'from': data['from'],
          'into': data['into'],
          'stats': data['stats'],
          'tags': data['tags'],
        };

  final Items _factory;
  final Map _extra;
  @override
  final String blurb;

  @override
  final bool inStore;

  @override
  Future<Iterable<api.Item>> get buildsFrom =>
      buildItemList(_extra['from'], _factory);

  @override
  Future<Iterable<api.Item>> get buildsInto =>
      buildItemList(_extra['into'], _factory);

  @override
  final int depth;

  @override
  final String description;

  @override
  final api.ImageIcon icon;

  @override
  final int id;

  @override
  Iterable<GameMap> get maps {
    var data = _extra['maps'];
    var list = <GameMap>[];

    GameMap.values.forEach((map) {
      if (data.containsKey(map.code)) {
        list.add(map);
      }
    });

    return list;
  }

  @override
  final String name;

  @override
  final api.Price price;

  @override
  Map<ItemStat, num> get stats => buildItemStats(_extra['stats']);

  @override
  Iterable<Tag> get tags => buildItemTags(_extra['tags']);
}

class Price implements api.Price {
  @override
  final int base;

  @override
  final bool canPurchase;

  @override
  final int sell;

  @override
  final int total;

  Price(Map data)
      : base = data['base'],
        sell = data['sell'],
        total = data['total'],
        canPurchase = data['purchasable'];
}
