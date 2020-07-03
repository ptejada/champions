import 'package:champions/src/exceptions.dart';
import 'package:champions/src/store_base.dart';
import 'package:champions/src/utils.dart';
import 'package:champions/storage.dart';
import 'package:test/test.dart';

void main() {
  group('Default language and version', () {
    Store store;

    setUp(() {
      store = Store();
    });

    test('Base URL builder', () {
      expect(store.url.versions(), endsWith('.com/api/versions.json'));
    });

    test('Image url builder', () {
      expect(store.url.image('champion/Aatrox'),
          endsWith('/cdn/10.12.1/img/champion/Aatrox.png'));

      expect(store.url.image('champion/Aatrox.png'),
          endsWith('/cdn/10.12.1/img/champion/Aatrox.png'));
    });

    test('Data url builder', () {
      expect(store.url.document('champion'),
          endsWith('/cdn/10.12.1/data/en_US/champion.json'));
      expect(store.url.document('champion.json'),
          endsWith('/cdn/10.12.1/data/en_US/champion.json'));
      expect(store.url.document('champion/Aatrox'),
          endsWith('/cdn/10.12.1/data/en_US/champion/Aatrox.json'));
      expect(store.url.document('champion/Aatrox.json'),
          endsWith('/cdn/10.12.1/data/en_US/champion/Aatrox.json'));
    });

    test('Network exception', () async {
      var resource = Resource(store.url.document('test'), () => {});
      var matchMessage =
          (NetworkException e) => e.message.contains('`403 Forbidden`');

      expect(() async => await store.fetch(resource),
          throwsA(allOf(isA<NetworkException>(), predicate(matchMessage))));
    });
  });

  test('Language builder', () {

    expect(enumFromString(Language.values, 'en_US'), equals(Language.en_US));
    expect(
        () => enumFromString(Language.values, 'en'),
        throwsA(allOf([
          isA<EnumException<Language>>(),
          predicate<EnumException>(
              (e) => e.message == 'The Language code en is not supported.')
        ])));
  });

  test('Dynamic store builder by region', () async {
    var store = await Store.forRegion(Region.na);
    expect(store.language, equals(Language.en_US));
    expect(store.version, isNotEmpty);
  });
}
