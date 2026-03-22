import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controller/daily_quests_controller.dart';

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

    int doneQuests = context.watch<DailyQuestsController>().getQuestsDone();

    double value = doneQuests / length;

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 5,
            width: 150,
            //smooth animation for the progress indicator
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0, end: value),
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green,
                  minHeight: 20,
                  value: value,
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(" $doneQuests / $length Todos done"),
        ],
      ),
    );
  }
}
