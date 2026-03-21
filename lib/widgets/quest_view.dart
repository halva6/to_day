import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controller/daily_quests_controller.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/widgets/empty_widget.dart';
import 'package:to_day/widgets/quest_list.dart';
import 'package:to_day/widgets/view_header.dart';

class QuestView extends StatelessWidget {
  const QuestView({super.key});
  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuestsController>();
    final dailyMap = dailyQuests.getDailyQuests();
    final selectedDate = dailyQuests.getSelectedDateTime();

    return Column(
      children: [
        ViewHeader(selectedDate: selectedDate),
        const Divider(),
        Expanded(
          child: (dailyMap.isEmpty || !dailyMap.containsKey(selectedDate))
              ? const EmptyQuest()
              : QuestList(
                  currentDailyQuest: dailyMap[selectedDate] ?? DailyQuest(),
                  selectedDate: selectedDate,
                ),
        ),
      ],
    );
  }
}
