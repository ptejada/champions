import 'api_assets.dart';
import 'item_enums.dart';

/// Callback to filter the champion list
typedef ItemFilter = bool Function(Item item);

/// Champion item
abstract class Item {
  /// Unique numeric id
  final int id;

  /// Whether the item is in store
  final bool inStore;

  /// Display name
  final String name;

  /// Detailed description with item stats info
  final String description;

  /// Blurb or tip
  final String blurb; // The `plaintext`
  /// List of other items this item can be build to
  final Future<Iterable<Item>> buildsInto;

  /// List of items required to build this item
  final Future<Iterable<Item>> buildsFrom;

  /// Item icon
  final ImageIcon icon;

  /// List of item tags
  final Iterable<Tag> tags;

  /// Item price information
  final Price price;

  /// The maps where this item is available on
  final Iterable<GameMap> maps;

  /// List of item stats
  final Map<ItemStat, num> stats;

  /// Build chain depth
  final int depth;

  Item._(
      this.id,
      this.inStore,
      this.name,
      this.description,
      this.blurb,
      this.buildsInto,
      this.buildsFrom,
      this.icon,
      this.tags,
      this.price,
      this.maps,
      this.stats,
      this.depth);
}

/// Item value in gold
abstract class Price {
  /// Base price in gold
  final int base;

  /// If the item can be purchased in the shop
  final bool canPurchase;

  /// The total cost of the item
  final int total;

  /// The sell value of the item
  final int sell;

  Price._(this.base, this.canPurchase, this.total, this.sell);
}
