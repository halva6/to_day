import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:to_day/controller/daily_quests_controller.dart';

class ViewHeader extends StatelessWidget {
  const ViewHeader({super.key, required this.selectedDate});

  final DateTime selectedDate;

  bool isDateToDay(DateTime selectDate) {
    DateTime today = DateTime.now();
    return (selectDate.year == today.year &&
        selectDate.month == today.month &&
        selectDate.day == today.day);
  }

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuestsController>();
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(0, 5, 0, 0),
      child: SizedBox(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Date: ${selectedDate.month} / ${selectedDate.day}",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: (isDateToDay(selectedDate))
                            ? FontWeight.w800
                            : FontWeight.normal,
                      ),
                    ),
                    Text(DateFormat('EEEE').format(selectedDate)),
                  ],
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
      ),
    );
  }
}
