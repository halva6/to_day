import 'package:flutter/material.dart';
import 'package:to_day/model/quest.dart';

class DailyQuests extends ChangeNotifier {
  final Map<DateTime, DailyQuest> _dailyQuests = {};

  DateTime _selectedDateTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  bool _editing = false;

  void addDailyQuest(DateTime dateTime, DailyQuest dailyQuest) {
    if (!_dailyQuests.containsKey(dateTime)) {
      _dailyQuests[dateTime] = dailyQuest;
    }
    notifyListeners();
  }

  void addQuest(DateTime selectedDate, String quest) {
    _dailyQuests[selectedDate]!.addItem(quest);
    notifyListeners();
  }

  Map<DateTime, DailyQuest> getDailyQuests() => _dailyQuests;

  DateTime getSelectedDateTime() => _selectedDateTime;

  bool isEditing() => _editing;

  void toggleDone(DateTime selectedDate, int index, bool value) {
    _dailyQuests[selectedDate]!.getQuests()[index].setDone(value);
    notifyListeners();
  }

  void changeQuest(DateTime selectDateTime, int index, String value) {
    _dailyQuests[selectDateTime]!.getQuests()[index].setQuest(value);
    notifyListeners();
  }

  void selectDateTime(DateTime selectedDateTime) {
    _selectedDateTime = selectedDateTime;
    notifyListeners();
  }

  void setEditing(bool isEditing) {
    _editing = isEditing;
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
