import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';

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
    return Stack(
      children: [
        ListView.builder(
          itemCount: currentDailyQuest.getQuests().length,
          itemBuilder: (BuildContext contextItemBuilder, int index) {
            final quest = currentDailyQuest.getQuests()[index];
            return ListTile(
              leading: Checkbox(
                value: quest.getDone(),
                onChanged: (bool? newValue) {
                  context.read<DailyQuests>().toggleDone(
                    selectedDate,
                    index,
                    newValue ?? false,
                  );
                },
              ),
              title: Text(quest.getQuest()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  const Icon(Icons.list),
                ],
              ),
            );
          },
        ),
        Align(
          alignment: const Alignment(0.8, 0.8),
          child: FloatingActionButton(
            onPressed: () {},
            tooltip: "Add",
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
