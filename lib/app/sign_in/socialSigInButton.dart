import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/customWidgets/customElevatedButton.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor = Colors.white,
    VoidCallback onPressed,
  })  : assert(text != null),
        assert(assetName != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(text),
              Opacity(opacity: 0.0, child: Image.asset(assetName)),
            ],
          ),
          backgroundColor: color,
          foregroundColor: textColor,
          onPressed: onPressed,
        );
}
