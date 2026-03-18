import 'package:flutter/material.dart';
import 'package:to_day/widgets/calendar_view.dart';
import 'package:to_day/widgets/quest_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: const Color.fromARGB(255, 33, 124, 167),
    );
    return MaterialApp(
      title: 'To Day',
      theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
      home: const MainPage(title: 'To Day'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    CalendarView calendarView = CalendarView();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            QuestView(),
            SizedBox(height: 10),
            calendarView,
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
