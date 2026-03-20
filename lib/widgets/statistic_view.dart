import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';

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
    context.read<DailyQuests>().sumupStats(selectedDate);
    return Center(
      child: Text(
        " ${context.watch<DailyQuests>().getQuestsDone()} / $length Todos done",
      ),
    );
  }
}
