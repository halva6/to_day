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
    ThemeData themeContext = Theme.of(context);
    final dailyQuests = context.watch<DailyQuests>();

    return (dailyQuests.getDailyQuests().isEmpty ||
            !dailyQuests.getDailyQuests().containsKey(
              dailyQuests.getSelectedDateTime(),
            ))
        ? EmptyQuest()
        : Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Quests:", style: themeContext.textTheme.headlineSmall),
              ],
            ),
          );
  }
}

class EmptyQuest extends StatelessWidget {
  const EmptyQuest({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuests>();

    return Center(
      child: Column(
        children: [
          Text("No entry at this date"),
          TextButton(
            onPressed: () {
              dailyQuests.addQuest(
                dailyQuests.getSelectedDateTime(),
                DailyQuest(),
              );
            },
            child: Text("add new Quest"),
          ),
        ],
      ),
    );
  }
}
