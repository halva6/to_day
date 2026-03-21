import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/model/quest.dart';

class DailyQuestsController extends ChangeNotifier {
  // diffrent attributes
  final Map<DateTime, DailyQuest> _dailyQuests = {};

  var box = Hive.box<DailyQuest>('daily_quest');
  DateTime _selectedDateTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  int? editingIndex;
  int _questsDone = 0;

  //constructor
  DailyQuestsController() {
    if (box.keys.isNotEmpty) {
      for (var key in box.keys) {
        var dailyQuest = box.get(key);
        _dailyQuests[stringToDateTime(key)] = dailyQuest ?? DailyQuest();
      }
    }
  }

  String dateTimeToString(DateTime dateTime) {
    return "${dateTime.year};${dateTime.month};${dateTime.day}";
  }

  DateTime stringToDateTime(String dateTimeString) {
    List<String> splittedList = dateTimeString.split(";");
    return DateTime.utc(
      int.parse(splittedList[0]),
      int.parse(splittedList[1]),
      int.parse(splittedList[2]),
    );
  }

  void _save(DateTime date) {
    box.put(dateTimeToString(date), _dailyQuests[date]!);
    _dailyQuests[date]?.save();
  }

  // editing
  bool isEditing(int index) => editingIndex == index;

  void startEditing(int index) {
    editingIndex = index;
    notifyListeners();
  }

  void stopEditing() {
    editingIndex = null;
    notifyListeners();
  }

  // quests
  void addDailyQuest(DateTime dateTime, DailyQuest dailyQuest) {
    if (!_dailyQuests.containsKey(dateTime)) {
      _dailyQuests[dateTime] = dailyQuest;
      _save(dateTime);
    }
    notifyListeners();
  }

  void addQuest(DateTime selectedDate, String quest) {
    _dailyQuests[selectedDate]!.addItem(quest);
    _save(selectedDate);

    notifyListeners();
  }

  //getter
  Map<DateTime, DailyQuest> getDailyQuests() => _dailyQuests;

  DateTime getSelectedDateTime() => _selectedDateTime;

  int getQuestsDone() => _questsDone;

  //setter or actions witch specificly toggles the notfiyListners()
  void toggleDone(DateTime selectedDate, int index, bool value) {
    _dailyQuests[selectedDate]!.getQuests()[index].setDone(value);
    _save(selectedDate);
    notifyListeners();
  }

  void changeQuest(DateTime selectedDate, int index, String value) {
    _dailyQuests[selectedDate]!.getQuests()[index].setQuest(value);
    _save(selectedDate);

    notifyListeners();
  }

  void selectDateTime(DateTime selectedDate) {
    _selectedDateTime = selectedDate;
    notifyListeners();
  }

  void removeQuest(DateTime selectedDate, int index) {
    _dailyQuests[selectedDate]!.getQuests().removeAt(index);
    _save(selectedDate);

    notifyListeners();
  }

  void previousOrNextDate(DateTime selectDate, int dateDifference)
  {
    _selectedDateTime = selectDate.add(Duration(days:-dateDifference));
    notifyListeners();
  }

  void sumupStats(DateTime selectedDate) {
    if (_dailyQuests[selectedDate] != null) {
      DailyQuest dailyQuest = _dailyQuests[selectedDate]!;
      int count = 0;
      for (Quest quest in dailyQuest.getQuests()) {
        count += (quest.getDone()) ? 1 : 0;
      }
      _questsDone = count;
    }
  }
}
