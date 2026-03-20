import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controller/daily_quests_controller.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/widgets/empty_widget.dart';
import 'package:to_day/widgets/quest_list.dart';

class QuestView extends StatelessWidget {
  const QuestView({super.key});
  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuestsController>();
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
