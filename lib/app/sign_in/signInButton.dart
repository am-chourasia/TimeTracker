import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/customWidgets/customElevatedButton.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor = Colors.white,
    VoidCallback onPressed,
  }) :  assert(text != null),
        super(
          child: Text(text),
          backgroundColor: color,
          foregroundColor: textColor,
          onPressed: onPressed,
        );
}
