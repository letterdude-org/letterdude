import 'package:flutter/material.dart';

Future<String?> showInputDialog({
  required BuildContext context,
  required String title,
  String? labelText,
  String? hintText,
  String cancelText = 'Cancel',
  String confirmText = 'Add',
}) {
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.pop(context, value);
              }
            },
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
