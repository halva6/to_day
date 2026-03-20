import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day/controll/daily_quests_controller.dart';

class InlineText extends StatefulWidget {
  final TextEditingController controller;
  final int index;

  const InlineText({super.key, required this.controller, required this.index});

  @override
  State<InlineText> createState() => _InlineTextState();
}

class _InlineTextState extends State<InlineText> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        context.read<DailyQuestsController>().stopEditing();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyQuests = context.watch<DailyQuestsController>();
    final selectedDate = dailyQuests.getSelectedDateTime();

    final isEditing = dailyQuests.isEditing(widget.index);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!isEditing) {
          context.read<DailyQuestsController>().startEditing(widget.index);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _focusNode.requestFocus();
          });
        }
      },
      child: isEditing
          ? TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
              autofocus: true,
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<DailyQuestsController>().stopEditing();
                context.read<DailyQuestsController>().changeQuest(
                  selectedDate,
                  widget.index,
                  widget.controller.text,
                );
              },

              onSubmitted: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<DailyQuestsController>().stopEditing();
                context.read<DailyQuestsController>().changeQuest(
                  selectedDate,
                  widget.index,
                  widget.controller.text,
                );
              },

              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            )
          : Text(widget.controller.text),
    );
  }
}
