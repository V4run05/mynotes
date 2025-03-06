import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 244, 249, 255),
        title: Text(
          title,
          style: TextStyle(
            color: Color.fromARGB(255, 31, 32, 33),
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: Color.fromARGB(255, 31, 32, 33),
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
          ),
        ),
        actions:
            options.keys.map((optionTitle) {
              final value = options[optionTitle];
              return TextButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  optionTitle,
                  style: TextStyle(
                    color: Color.fromARGB(255, 31, 32, 33),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
      );
    },
  );
}
