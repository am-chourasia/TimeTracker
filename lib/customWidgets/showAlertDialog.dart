import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
  String cancelActionText,
  @required defaultActionText,
}) {
  return showDialog(
    barrierDismissible: true,
    // Will clicking outside the Dialog gets out of Dialog box
    // default value is true, therefor the function can also return null value when clicked outside the Dialog.
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
            // false will be returned
          ),
        TextButton(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
          // true value will be returned
        )
      ],
    ),
  );
}
