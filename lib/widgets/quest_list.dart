import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controller/daily_quests_controller.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/widgets/add_button.dart';
import 'package:to_day/widgets/inline_text.dart';
import 'package:to_day/widgets/statistic_view.dart';

class QuestList extends StatelessWidget {
  const QuestList({
    super.key,
    required this.currentDailyQuest,
    required this.selectedDate,
  });

  final DailyQuest currentDailyQuest;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final int length = currentDailyQuest.getQuests().length;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: length,
                itemBuilder: (BuildContext contextItemBuilder, int index) {
                  final quest = currentDailyQuest.getQuests()[index];
                  return ListTile(
                    leading: Checkbox(
                      value: quest.getDone(),
                      onChanged: (bool? newValue) {
                        context.read<DailyQuestsController>().toggleDone(
                          selectedDate,
                          index,
                          newValue ?? false,
                        );
                      },
                    ),
                    title: InlineText(
                      controller: TextEditingController(text: quest.getQuest()),
                      index: index,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<DailyQuestsController>().removeQuest(
                          selectedDate,
                          index,
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 70,
              child: StatisticView(selectedDate: selectedDate, length: length),
            ),
          ],
        ),
        AddButton(selectedDate: selectedDate),
      ],
    );
  }
}
