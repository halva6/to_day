import 'package:hive/hive.dart';
import 'package:to_day/model/quest.dart';

part 'daily_quest.g.dart';

@HiveType(typeId: 0)
class DailyQuest extends HiveObject {
  @HiveField(0)
  List<Quest> _quests;

  DailyQuest({List<Quest>? quests})
      : _quests = quests ?? [Quest("Add TODO", false)];

  void addItem(String quest) {
    _quests.add(Quest(quest, false));
  }

  void removeItem(int index) {
    _quests.removeAt(index);
  }

  void itemNewPlace(int deleteIndex, int newLocationIndex) {
    Quest tempQuest = _quests.removeAt(deleteIndex);
    _quests.insert(newLocationIndex, tempQuest);
  }

  void editQuest(int index, String editedQuest) {
    _quests.elementAt(index).setQuest(editedQuest);
  }

  void editDone(int index, bool editedDone) {
    _quests.elementAt(index).setDone(editedDone);
  }

  List<Quest> getQuests() => _quests;

  @override
  String toString() {
    return "Quests: ${_quests.toString()}";
  }
}
