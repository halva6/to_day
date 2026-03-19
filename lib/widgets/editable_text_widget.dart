import 'package:flutter/material.dart';

class InlineText extends StatefulWidget {
  final String initialText;
  final TextStyle? style;
  final ValueChanged<String>? onSubmitted;

  const InlineText({
    super.key,
    required this.initialText,
    this.style,
    this.onSubmitted,
  });

  @override
  createState() => _InlineTextState();
}

class _InlineTextState extends State<InlineText> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _saveText();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      _focusNode.requestFocus();
    });
  }

  void _saveText() {
    setState(() {
      _isEditing = false;
    });

    if (widget.onSubmitted != null) {
      widget.onSubmitted!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!_isEditing) {
          _startEditing();
        }
      },
      child: _isEditing
          ? TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: widget.style,
              textInputAction: TextInputAction.done,

              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },

              onSubmitted: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
                _saveText();
              },
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            )
          : Text(_controller.text, style: widget.style),
    );
  }
}
