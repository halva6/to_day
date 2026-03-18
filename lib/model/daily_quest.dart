import 'package:flutter/material.dart';
import 'package:to_day/model/quest.dart';

class DailyQuests extends ChangeNotifier {
  final Map<DateTime, DailyQuest> _dailyQuests = {};

  DateTime _selectedDateTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  void addQuest(DateTime dateTime, DailyQuest dailyQuest) {
    if (!_dailyQuests.containsKey(dateTime)) {
      _dailyQuests[dateTime] = dailyQuest;
    }
    notifyListeners();
  }

  Map<DateTime, DailyQuest> getDailyQuests() => _dailyQuests;
  DateTime getSelectedDateTime() => _selectedDateTime;
  void selectDateTime(DateTime selectedDateTime) {
    _selectedDateTime = selectedDateTime;
    notifyListeners();
  }
}

class DailyQuest {
  final List<Quest> _quests = [Quest("add TODO", false)];
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
}
