import 'package:http/http.dart';

/// Interface for the library exceptions
abstract class _ChampionException implements Exception {
  /// The exception message
  final String message;

  _ChampionException(this.message);
}

/// Exception for when a network error occurs
class NetworkException implements _ChampionException {
  final Response response;

  /// The HTTP response code
  int get code => response.statusCode;

  /// The HTTP method of the request that failed
  String get method => response.request.method;

  /// The HTTP code + reason phrase of request failure
  String get reason => '$code ${response.reasonPhrase}';

  /// The HTTP URI of the failing request
  Uri get url => response.request.url;

  /// The body of the failing request
  String get body => response.body;

  /// The detailed network exception message
  @override
  String get message => '`$method $url` resulted in a `$reason`';

  NetworkException(this.response);
}

/// Enum related exception
class EnumException<T> extends _ChampionException {
  EnumException(String message) : super(message);
}
