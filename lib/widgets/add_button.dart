import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.8, 0.8),
      child: FloatingActionButton(
        onPressed: () {
          context.read<DailyQuests>().addQuest(selectedDate, "TODO");
        },
        tooltip: "Add",
        child: const Icon(Icons.add),
      ),
    );
  }
}
