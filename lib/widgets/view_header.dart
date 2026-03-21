import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controller/daily_quests_controller.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuestsController>();
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            height: 40,
            child: FloatingActionButton(
              onPressed: () => dailyQuests.previousOrNextDate(selectedDate, 1),
              child: const Icon(Icons.keyboard_arrow_left),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Date: ${selectedDate.month} / ${selectedDate.day}",
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: FloatingActionButton(
              onPressed: () => dailyQuests.previousOrNextDate(selectedDate, -1),
              child: const Icon(Icons.keyboard_arrow_right),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
