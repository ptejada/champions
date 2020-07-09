![Dart CI](https://github.com/ptejada/champions/workflows/Dart%20CI/badge.svg)

A Dart library for the League of Legends static data or Data Dragon database.

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

1. List of champion spells, and their corresponding assets like images and videos.
2. Information about champion passive including icon.
3. ~~Add the extended version of the lore.~~
4. ~~Include tips for allies and enemies.~~
5. ~~Add champion skins.~~
6. Add champion splash arts assets.
7. Add loading screen assets.
8. Add items library.
9. Add library for summoner spells.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ptejada/champions/issues
