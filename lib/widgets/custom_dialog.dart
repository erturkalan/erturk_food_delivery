import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? message;
  final String? okText;
  final Function? okPressed;
  final bool isSecondButtonAvailable;
  final String? secondButtonText;
  final Function? secondButtonPressed;

  const CustomDialog(
      {this.okText,
      this.okPressed,
      Key? key,
      this.message,
      this.isSecondButtonAvailable = false,
      this.secondButtonText,
      this.secondButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message!),
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
