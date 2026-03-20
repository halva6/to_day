import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controll/daily_quests_controller.dart';
import 'package:to_day/model/daily_quest.dart';

class EmptyQuest extends StatelessWidget {
  const EmptyQuest({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuestsController>();
    final ThemeData themeContext = Theme.of(context);

    return Padding(
      padding: EdgeInsetsGeometry.all(20),
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
              dailyQuests.addDailyQuest(
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