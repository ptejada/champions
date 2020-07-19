## 0.2.1
- Added library champion items
## 0.2.0
- Added ChampionSpell.clip pointing to the spell video clip, and the clip thumbnail.
- Fixes issue with the public interface for **Champion**. The **allyTips** and **enemyTips** props 
are now `Iterable<String>` type.
- Added test to check load all the champion lazy objects are parse and mapped as expected
## 0.1.1
- Added champion spells collection.
- Added champion passive information.
## 0.1.0
- Abstract the public facing API to interfaces to is easier to keep track the public api changes.
- Added partial support for extra champion information like skins, lore and tips.
- Improves and brings more clarity to the public API.
- Initial version including the basic champion information and stats.
