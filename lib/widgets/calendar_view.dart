import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_day/model/daily_quest.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});
  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final DailyQuests dailyQuests = context.watch<DailyQuests>();

    return TableCalendar(
      focusedDay: _today,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2040, 3, 14),
      headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
      rowHeight: 40,
      onDaySelected: (day, focusedDay) {
        setState(() {
          _today = day;
        });
        dailyQuests.selectDateTime(day);
      },
      selectedDayPredicate: (day) => isSameDay(day, _today),
    );
  }
}
