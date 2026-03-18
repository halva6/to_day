import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';

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

    if ((dailyMap.isEmpty ||
        !dailyMap.containsKey(dailyQuests.getSelectedDateTime()))) {
      return EmptyQuest();
    } else {
      DailyQuest? currentDailyQuest =
          dailyMap[dailyQuests.getSelectedDateTime()];
      return Expanded(
        child: ListView.builder(
          itemCount: currentDailyQuest!.getQuests().length,
          itemBuilder: (BuildContext context, int index) {
            bool done = currentDailyQuest.getQuests()[index].getDone();
            return ListTile(
              leading: Checkbox(
                value: done,
                onChanged: (bool? newValue) {
                  setState(() {
                    done = (newValue != null) ? newValue : false;
                    context
                        .read<DailyQuests>()
                        .getDailyQuests()[dailyQuests.getSelectedDateTime()]!
                        .getQuests()[index]
                        .setDone(done);
                  });
                },
              ),
              title: Text(currentDailyQuest.getQuests()[index].getQuest()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Icon(Icons.list)],
              ),
            );
          },
        ),
      );
    }
  }
}

class EmptyQuest extends StatelessWidget {
  const EmptyQuest({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuests>();
    final ThemeData themeContext = Theme.of(context);

    return Center(
      child: Column(
        children: [
          const Text("No entry at this date"),
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                themeContext.highlightColor,
              ),
            ),
            onPressed: () {
              dailyQuests.addQuest(
                dailyQuests.getSelectedDateTime(),
                DailyQuest(),
              );
            },
            child: const Text("add new Quest"),
          ),
        ],
      ),
    );
  }
}
