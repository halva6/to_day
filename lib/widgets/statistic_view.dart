import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controll/daily_quests_controller.dart';

class StatisticView extends StatelessWidget {
  const StatisticView({
    super.key,
    required this.length,
    required this.selectedDate,
  });

  final int length;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    context.read<DailyQuestsController>().sumupStats(selectedDate);
    return Center(
      child: Text(
        " ${context.watch<DailyQuestsController>().getQuestsDone()} / $length Todos done",
      ),
    );
  }
}
