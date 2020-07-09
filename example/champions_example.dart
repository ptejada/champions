import 'package:champions/champions.dart';

void main() async {
  // Creates the champions for reference for NA with the latest patch version
  // and default language
  var champions = await Champions.forRegion(Region.na);

  // Get the list of all champions
  var list = (await champions.all).values;

  // Or only of Marksman champions
  list = await champions.withRole(Role.marksman);

  // Or only list of champions filtered by name
  list = await champions.search('ann');

  // Or only list of champions filtered by custom criteria
  // For example filter the list by champions with at least 600 base HP
  list = await champions.filter((champ) => champ.stats.hp >= 600);

  // Print the name and title for each champion in the list
  list.forEach((Champion champ) {
    print('${champ.name} - ${champ.title}');
  });
}
