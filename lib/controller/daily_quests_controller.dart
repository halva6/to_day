import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:home_widget/home_widget.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/model/quest.dart';

class DailyQuestsController extends ChangeNotifier {
  final appGroupId = "group.ToDayApp";
  final andriodWidgetName = "TodoWidget";
  final dataKey = "text_from_todo_app";

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
    HomeWidget.setAppGroupId(appGroupId);

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

  void _save(DateTime date) async {
    await box.put(dateTimeToString(date), _dailyQuests[date]!);
    await _dailyQuests[date]?.save();
  }

  List<String> _getAllUndoneTodos(DailyQuest data) {
    List<String> undoneTodos = [];
    for (Quest quest in data.getQuests()) {
      if (!quest.getDone()) {
        undoneTodos.add(quest.getQuest());
      }
    }
    return undoneTodos;
  }

  void _updateWidget(DailyQuest data) async {
    // save widget data
    List<String> undoneTodos = _getAllUndoneTodos(data);
    await HomeWidget.saveWidgetData(
      dataKey,
      jsonEncode(undoneTodos.isNotEmpty ? undoneTodos : []),
    );

    // update widget
    await HomeWidget.updateWidget(androidName: andriodWidgetName);
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
      _updateWidget(dailyQuest);
    }
    notifyListeners();
  }

  void addQuest(DateTime selectedDate, String quest) {
    _dailyQuests[selectedDate]!.addItem(quest);
    _save(selectedDate);
    _updateWidget(_dailyQuests[selectedDate] ?? DailyQuest());

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
    _updateWidget(_dailyQuests[selectedDate] ?? DailyQuest());

    notifyListeners();
  }

  void changeQuest(DateTime selectedDate, int index, String value) {
    _dailyQuests[selectedDate]!.getQuests()[index].setQuest(value);
    _save(selectedDate);
    _updateWidget(_dailyQuests[selectedDate] ?? DailyQuest());

    notifyListeners();
  }

  void selectDateTime(DateTime selectedDate) {
    _selectedDateTime = selectedDate;
    notifyListeners();
  }

  void removeQuest(DateTime selectedDate, int index) {
    _dailyQuests[selectedDate]!.getQuests().removeAt(index);
    if (_dailyQuests[selectedDate]!.getQuests().isEmpty) {
      box.delete(dateTimeToString(selectedDate));
      _dailyQuests.remove(selectedDate);
    } else {
      _updateWidget(_dailyQuests[selectedDate] ?? DailyQuest());
      _save(selectedDate);
    }

    notifyListeners();
  }

  void previousOrNextDate(DateTime selectDate, int dateDifference) {
    _selectedDateTime = selectDate.add(Duration(days: -dateDifference));
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
