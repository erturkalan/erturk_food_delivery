import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;

  const ErrorDialog({this.errorMessage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(errorMessage!),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Center(child: Text('OK')),
        ),
      ],
    );
  }
}
