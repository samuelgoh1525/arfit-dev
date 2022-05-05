import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String caption;
  final List<Widget>? actions;
  const AlertWidget({
    Key? key,
    required this.title,
    required this.caption,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(caption),
      actions: actions,
    );
  }
}
