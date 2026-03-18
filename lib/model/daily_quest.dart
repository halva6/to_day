import 'package:to_day/model/quest.dart';

class DailyQuest 
{
  final List<Quest> _quests = List.empty(growable: true);
  final DateTime _date;

  DailyQuest(this._date);

  void addItem(String quest)
  {
    _quests.add(Quest(quest, false));
  }

  void removeItem(int index)
  {
    _quests.removeAt(index);
  }

  void itemNewPlace(int deleteIndex, int newLocationIndex)
  {
    Quest tempQuest = _quests.removeAt(deleteIndex);
    _quests.insert(newLocationIndex, tempQuest);
  }

  void editQuest(int index, String editedQuest)
  {
    _quests.elementAt(index).setQuest(editedQuest);
  }

  void editDone(int index, bool editedDone)
  {
    _quests.elementAt(index).setDone(editedDone);
  }

  List<Quest> getQuests() => _quests;
  DateTime getDate() => _date;
}