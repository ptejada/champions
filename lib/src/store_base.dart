import 'dart:convert' as convert;
import 'exceptions.dart';
import 'package:http/http.dart' as http;
import 'store_enums.dart';
import 'utils.dart';

/// Static asset storage
class Store {
  final _UrlGenerator url;

  const Store([this.url = const _UrlGenerator()]);

  /// The active language
  Language get language => url.language;

  /// the active patch version
  String get version => url.version;

  /// Generates a region specific store with default language and API version
  static Future<Store> forRegion(Region region) async {
    final store = Store();

    var response = await store.realm(region).fetch();
    var lang = enumFromString<Language>(Language.values, response['l']);
    String version = response['v'];

    return Store(_UrlGenerator(version: version, language: lang));
  }

  /// Reference for a data json file
  Resource document(String document) {
    return Resource(url.document(document), fetch);
  }

  /// Reference for an image file
  Resource image(String image) {
    return Resource(url.image(image), fetch);
  }

  /// Region or realm information
  Resource realm(Region region) => Resource(url.realm(region), fetch);

  /// Fetch a resource from the network
  Future fetch(Resource resource) async {
    var response = await http.get(resource.url);

    if (response.statusCode == 200) {
      if (resource.type == 'json') {
        return convert.jsonDecode(response.body);
      }

      return response.body;
    }

    throw NetworkException(response);
  }
}

/// Generates all the Data Dragon Urls
class _UrlGenerator {
  /// The base URL
  final String baseUrl;

  /// The patch version
  final String version;

  /// The language for documents
  final Language language;

  const _UrlGenerator(
      {this.baseUrl = 'http://ddragon.leagueoflegends.com',
      this.version = '10.12.1',
      this.language = Language.en_US});

  String _resource(String doc, [String ext]) => '$baseUrl/${_suffix(doc, ext)}';

  String _asset(String asset, [String ext]) =>
      _resource('cdn/$version/$asset', ext);

  /// Generates URL for an image
  String image(String image) => _asset('img/$image', 'png');

  /// Generates URL for json or data document
  String document(String document) =>
      _asset('data/${language.code}/$document', 'json');

  /// Generates URL for realm document
  String realm(Region region) => _resource('realms/${region.code}', 'json');

  String _suffix(String base, [String ext]) {
    if (ext != null) {
      final suffix = '.$ext';

      return base.endsWith(suffix) ? base : '$base$suffix';
    }

    return base;
  }

  String versions() => _resource('api/versions.json');
}

/// Represents a network resource
class Resource {
  final String url;
  final Function _resolver;

  /// Resource type or file extension
  String get type => url.split('.').last;

  /// Creates storage resource reference
  ///
  /// The [resolver] function is used to fetch the resource. If not provided
  /// calling [fetch] will return the URL.
  Resource(this.url, Function resolver) : _resolver = resolver ?? (() => url);

  /// Downloads the resource from network
  Future fetch() async => _resolver(this);

  @override
  String toString() => url;
}
