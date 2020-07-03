import 'package:champions/src/exceptions.dart';
import 'package:enum_to_string/enum_to_string.dart';

/// Helper function to translate a string into an enum reference
T enumFromString<T>(List<T> values, String code, [T defaultEnum]) {
  final ref = EnumToString.fromString(values, code.replaceAll(' ', ''));

  if (ref != null) {
    return ref;
  }

  if (defaultEnum != null) {
    return defaultEnum;
  }

  final type = values.first.toString().split('.').first;

  throw EnumException<T>('The $type code $code is not supported.');
}
