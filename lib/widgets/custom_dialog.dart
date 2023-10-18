import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final String? okText;
  final Function? okPressed;
  final bool isSecondButtonAvailable;
  final String? secondButtonText;
  final Function? secondButtonPressed;

  const CustomDialog(
      {this.okText,
      this.okPressed,
      Key? key,
      required this.message,
      this.isSecondButtonAvailable = false,
      this.secondButtonText,
      this.secondButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          onPressed: () {
            okPressed != null ? okPressed!() : null;
            Navigator.of(context).pop();
          },
          child: Center(
              child: Text(okText ?? "Ok",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500))),
        ),
        isSecondButtonAvailable
            ? Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      secondButtonPressed != null
                          ? secondButtonPressed!()
                          : null;
                      Navigator.of(context).pop();
                    },
                    child: Center(
                        child: Text(secondButtonText!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500))),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
