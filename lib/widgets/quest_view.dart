import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/widgets/empty_widget.dart';
import 'package:to_day/widgets/quest_list.dart';

class QuestView extends StatefulWidget {
  const QuestView({super.key});
  @override
  State<QuestView> createState() => _QuestViewState();
}

class _QuestViewState extends State<QuestView> {
  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuests>();
    final dailyMap = dailyQuests.getDailyQuests();
    final selectedDate = dailyQuests.getSelectedDateTime();

    if ((dailyMap.isEmpty || !dailyMap.containsKey(selectedDate))) {
      return EmptyQuest();
    } else {
      return QuestList(
        currentDailyQuest: dailyMap[selectedDate] ?? DailyQuest(),
        selectedDate: selectedDate,
      );
    }
  }
}
