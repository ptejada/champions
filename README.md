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

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ptejada/champions/issues
