import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controller/daily_quests_controller.dart';
import 'package:to_day/model/daily_quest.dart';
import 'package:to_day/model/quest.dart';
import 'package:to_day/widgets/calendar_view.dart';
import 'package:to_day/widgets/quest_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(DailyQuestAdapter());
  Hive.registerAdapter(QuestAdapter());

  await Hive.openBox<DailyQuest>('daily_quest');
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
      home: ChangeNotifierProvider(
        create: (_) => DailyQuestsController(),
        child: Scaffold(
          drawer: CalendarView(),
          appBar: AppBar(
            backgroundColor: colorScheme.inversePrimary,
            title: Text(_headingText),
          ),
          body: Center(child: QuestView()),
        ),
      ),
    );
  }
}
