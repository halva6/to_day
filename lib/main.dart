import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/widgets/calendar_view.dart';
import 'package:to_day/widgets/quest_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String _headingText = "To Day";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: const Color.fromARGB(255, 33, 124, 167),
    );
    return MaterialApp(
      title: _headingText,
      theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.inversePrimary,
          title: Text(_headingText),
        ),
        body: Center(
          child: ChangeNotifierProvider(
            create: (_) => DailyQuests(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex:3, child: QuestView()),
                Expanded(flex:2, child: CalendarView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
