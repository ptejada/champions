import 'package:enum_to_string/enum_to_string.dart';

/// The champion roles
enum Role { assassin, fighter, mage, marksman, support, tank }

/// Provides the ability to get a label for a [Role] enum
extension RoleLabel on Role {
  String get label => EnumToString.parseCamelCase(this);
}

/// Champion ability resource
///
/// The most common options are [mana] and [none]. All other resources are
/// specific to one or a few champions
enum AbilityResource {
  mana,
  energy,
  none,
  rage,
  courage,
  shield,
  fury,
  ferocity,
  heat,
  grit,
  crimsonRush,
  flow,
  bloodWell,
  unknown,
}

/// Provides the ability to get a label from the an [AbilityResource] enum
extension AbilityResourceLabel on AbilityResource {
  String get label => EnumToString.parseCamelCase(this);
}
