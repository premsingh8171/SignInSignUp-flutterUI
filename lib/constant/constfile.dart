import 'package:flutter/material.dart';

class MyCustomDialog extends StatelessWidget {
  final String title;
  final String content;

  const MyCustomDialog({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          child: Text('Close'),
        ),
      ],
    );
  }
}
