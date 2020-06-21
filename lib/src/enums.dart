import 'dart:mirrors';
import 'package:champions/src/exceptions.dart';

abstract class _Enum {
  final String code;
  final String label;

  const _Enum(this.code, this.label);

  @override
  String toString() => code;
}

/// Generates enum from string
T _enumFromString<T extends _Enum>(String code){
  var name = Symbol(code);
  var instance = reflectClass(T);
  var member = instance.staticMembers[name];

  if (member != null && member.isStatic) {
    return instance.getField(name).reflectee;
  }

  throw EnumException<T>('The ${instance.reflectedType} code $code is not supported.');
}

/// The content language
class Language extends _Enum {
  String get lang => code.split('_').first;

  String get region => code.split('_').last;

  static const Language cs_CZ = Language('cs_CZ', 'Czech (Czech Republic)');
  static const Language el_GR = Language('el_GR', 'Greek (Greece)');
  static const Language pl_PL = Language('pl_PL', 'Polish (Poland)');
  static const Language ro_RO = Language('ro_RO', 'Romanian (Romania)');
  static const Language hu_HU = Language('hu_HU', 'Hungarian (Hungary)');
  static const Language en_GB = Language('en_GB', 'English (United Kingdom)');
  static const Language de_DE = Language('de_DE', 'German (Germany)');
  static const Language es_ES = Language('es_ES', 'Spanish (Spain)');
  static const Language it_IT = Language('it_IT', 'Italian (Italy)');
  static const Language fr_FR = Language('fr_FR', 'French (France)');
  static const Language ja_JP = Language('ja_JP', 'Japanese (Japan)');
  static const Language ko_KR = Language('ko_KR', 'Korean (Korea)');
  static const Language es_MX = Language('es_MX', 'Spanish (Mexico)');
  static const Language es_AR = Language('es_AR', 'Spanish (Argentina)');
  static const Language pt_BR = Language('pt_BR', 'Portuguese (Brazil)');
  static const Language en_US = Language('en_US', 'English (United States)');
  static const Language en_AU = Language('en_AU', 'English (Australia)');
  static const Language ru_RU = Language('ru_RU', 'Russian (Russia)');
  static const Language tr_TR = Language('tr_TR', 'Turkish (Turkey)');
  static const Language ms_MY = Language('ms_MY', 'Malay (Malaysia)');
  static const Language en_PH =
      Language('en_PH', 'English (Republic of the Philippines)');
  static const Language en_SG = Language('en_SG', 'English (Singapore)');
  static const Language th_TH = Language('th_TH', 'Thai (Thailand)');
  static const Language vn_VN = Language('vn_VN', 'Vietnamese (Viet Nam)');
  static const Language id_ID = Language('id_ID', 'Indonesian (Indonesia)');
  static const Language zh_MY = Language('zh_MY', 'Chinese (Malaysia)');
  static const Language zh_CN = Language('zh_CN', 'Chinese (China)');
  static const Language zh_TW = Language('zh_TW', 'Chinese (Taiwan)');

  const Language(String code, String label) : super(code, label);

  static Language fromString(String code) => _enumFromString<Language>(code);
}

/// Region or Realm
class Region extends _Enum {
  static const Region na = Region('na', 'North America');
  static const Region euw = Region('euw', 'Europe West');
  static const Region eun = Region('eun', 'Europe North & East');
  static const Region kr = Region('kr', 'Korea');
  static const Region br = Region('br', 'Brazil');
  static const Region jp = Region('jp', 'Japan');
  static const Region ru = Region('ru', 'Russia');
  static const Region oce = Region('oce', 'Oceania');
  static const Region tr = Region('tr', 'Turkey');
  static const Region lan = Region('lan', 'Latin America North');
  static const Region las = Region('las', 'Latin America South');

  const Region(String code, String label) : super(code, label);
}
