import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    this.child,
    this.backgroundColor, // takes default value from the theme colour
    this.foregroundColor = Colors.white,
    this.borderRadius = 12,
    this.height = 50,
    this.onPressed,
  })  : assert(borderRadius != null),
        assert(height != null); // to assert that that either the deafult value is used or the passed value is valid.
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: this.backgroundColor, // background
            onPrimary: this.foregroundColor, // foreground
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            )),
        child: this.child,
        onPressed: (this.onPressed == null)
            ? () {}
            : this
                .onPressed, // to assign the onPressed function if available or empty function if not available
      ),
    );
  }
}
