![Dart CI](https://github.com/ptejada/champions/workflows/Dart%20CI/badge.svg)

A Dart library for the League of Legends (LoL) static data or Data Dragon database.
All the original Data Dragon documentation and sources are available at the Riot Developer console 
<https://developer.riotgames.com/docs/lol>.

## Usage

A simple usage example:

```dart
import 'package:champions/champions.dart';

void main() {
  var champions = Champions();

  // Print the name and tittle of all champions
  champions.all.then((list) {
    list.values.forEach((Champion champ) {
      print('${champ.name} - ${champ.title}');
    });
  });

  // List of Marksman champions
  champions.withRole(Role.marksman);

  // List of champions that filtered by name
  champions.search('ann');
  
  // Filter the champion list by custom criteria
  // For example filter the list by champions with at least 600 base HP
  champions.filter((champ) => champ.stat.hp >= 600);
}
```

## Roadmap
This library is still under development below are the items that still need to be implemented:

1. ~~Add items library.~~
2. Add recommended item collections to champions.
3. Add library for summoner spells.
4. Add caching layer for all assets.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ptejada/champions/issues
