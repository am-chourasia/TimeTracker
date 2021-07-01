import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker/customWidgets/showAlertDialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  @required Exception exception,
  @required String title,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: "OK",
    );

String _message(Exception e) {
  if (e is FirebaseException) return e.message;
  return e.toString();
}
