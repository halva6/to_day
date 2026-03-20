import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_day/controll/daily_quests_controller.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});
  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime? _today;

  @override
  Widget build(BuildContext context) {
    final DailyQuestsController dailyQuests = context.watch<DailyQuestsController>();
    final ThemeData themeContext = Theme.of(context);
    _today = dailyQuests.getSelectedDateTime();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: themeContext.colorScheme.inversePrimary),
            child: Center(child: Text('To do, to day')),
          ),
          ListTile(
            title: TableCalendar(
              focusedDay: _today ?? DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2040, 3, 14),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              rowHeight: 60,
              onDaySelected: (day, focusedDay) {
                setState(() {
                  _today = day;
                });
                dailyQuests.selectDateTime(day);
              },
              selectedDayPredicate: (day) => isSameDay(day, _today),
            ),
          ),
        ],
      ),
    );
  }
}
