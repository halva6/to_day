import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/model/daily_quest.dart';

class InlineText extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode _focusNode = FocusNode();
  final TextStyle _style = TextStyle();
  final int index;

  InlineText({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuests>();
    final selectedDate = dailyQuests.getSelectedDateTime();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && dailyQuests.isEditing()) {
        context.read<DailyQuests>().setEditing(false);
      }
    });

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!dailyQuests.isEditing()) {
          context.read<DailyQuests>().setEditing(true);

          Future.delayed(const Duration(milliseconds: 50), () {
            _focusNode.requestFocus();
          });
        }
      },
      child: dailyQuests.isEditing()
          ? TextField(
              controller: controller,
              focusNode: _focusNode,
              style: _style,
              textInputAction: TextInputAction.done,

              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<DailyQuests>().setEditing(false);
                context.read<DailyQuests>().changeQuest(
                  selectedDate,
                  index,
                  controller.text,
                );
              },

              onSubmitted: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<DailyQuests>().setEditing(false);
                context.read<DailyQuests>().changeQuest(
                  selectedDate,
                  index,
                  controller.text,
                );
              },
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            )
          : Text(controller.text, style: _style),
    );
  }
}
