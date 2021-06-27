import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/customWidgets/customElevatedButton.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          backgroundColor: onPressed == null ? Colors.grey : Colors.indigo, 
          // background color is grey when the button is disabled, i.e. onPressed in null
          onPressed: onPressed,
        );
}
