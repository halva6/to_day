import 'package:flutter/material.dart';

class QuestView extends StatefulWidget {
  const QuestView({super.key});
  @override
  State<QuestView> createState() => _QuestViewState();
}

class _QuestViewState extends State<QuestView> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return Expanded(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Quests:", style: themeContext.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
