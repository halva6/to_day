import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});
  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
    });
  }

  bool _selectedDayPredicate(DateTime day) => isSameDay(day, _today);

  DateTime getToDay() => _today;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _today,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2040, 3, 14),
      headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
      rowHeight: 40,
      onDaySelected: _onDaySelected,
      selectedDayPredicate: _selectedDayPredicate,
    );
  }
}
