import 'package:enum_to_string/enum_to_string.dart';

/// Localization Languages
enum Language {
  cs_CZ,
  el_GR,
  pl_PL,
  ro_RO,
  hu_HU,
  en_GB,
  de_DE,
  es_ES,
  it_IT,
  fr_FR,
  ja_JP,
  ko_KR,
  es_MX,
  es_AR,
  pt_BR,
  en_US,
  en_AU,
  ru_RU,
  tr_TR,
  ms_MY,
  en_PH,
  en_SG,
  th_TH,
  vn_VN,
  id_ID,
  zh_MY,
  zh_CN,
  zh_TW,
}

/// Provides labels for [Language] enum
extension LanguageLabel on Language {
  String get code => EnumToString.parse(this);

  String get label {
    switch (this) {
      case Language.cs_CZ:
        return 'Czech (Czech Republic)';
      case Language.el_GR:
        return 'Greek (Greece)';
      case Language.pl_PL:
        return 'Polish (Poland)';
      case Language.ro_RO:
        return 'Romanian (Romania)';
      case Language.hu_HU:
        return 'Hungarian (Hungary)';
      case Language.en_GB:
        return 'English (United Kingdom)';
      case Language.de_DE:
        return 'German (Germany)';
      case Language.es_ES:
        return 'Spanish (Spain)';
      case Language.it_IT:
        return 'Italian (Italy)';
      case Language.fr_FR:
        return 'French (France)';
      case Language.ja_JP:
        return 'Japanese (Japan)';
      case Language.ko_KR:
        return 'Korean (Korea)';
      case Language.es_MX:
        return 'Spanish (Mexico)';
      case Language.es_AR:
        return 'Spanish (Argentina)';
      case Language.pt_BR:
        return 'Portuguese (Brazil)';
      case Language.en_US:
        return 'English (United States)';
      case Language.en_AU:
        return 'English (Australia)';
      case Language.ru_RU:
        return 'Russian (Russia)';
      case Language.tr_TR:
        return 'Turkish (Turkey)';
      case Language.ms_MY:
        return 'Malay (Malaysia)';
      case Language.en_PH:
        return 'English (Republic of the Philippines)';
      case Language.en_SG:
        return 'English (Singapore)';
      case Language.th_TH:
        return 'Thai (Thailand)';
      case Language.vn_VN:
        return 'Vietnamese (Viet Nam)';
      case Language.id_ID:
        return 'Indonesian (Indonesia)';
      case Language.zh_MY:
        return 'Chinese (Malaysia)';
      case Language.zh_CN:
        return 'Chinese (China)';
      case Language.zh_TW:
        return 'Chinese (Taiwan)';
      default:
        return EnumToString.parse(this);
    }
  }
}

/// Region or Realm
enum Region { na, euw, eun, kr, br, jp, ru, oce, tr, lan, las }

/// Provides labels for [Region] enum
extension RegionLabel on Region {
  String get code => EnumToString.parse(this);

  String get label {
    switch (this) {
      case Region.na:
        return 'North America';
      case Region.euw:
        return 'Europe West';
      case Region.eun:
        return 'Europe North & East';
      case Region.kr:
        return 'Korea';
      case Region.br:
        return 'Brazil';
      case Region.jp:
        return 'Japan';
      case Region.ru:
        return 'Russia';
      case Region.oce:
        return 'Oceania';
      case Region.tr:
        return 'Turkey';
      case Region.lan:
        return 'Latin America North';
      case Region.las:
        return 'Latin America South';
      default:
        return EnumToString.parse(this);
    }
  }
}
