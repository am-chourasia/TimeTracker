import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email_id@email.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            // primary: this.backgroundColor, // background
            // onPrimary: this.foregroundColor, // foreground
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(borderRadius),
            //   ),
            ),
        child: Text('Sign In'),
        onPressed: () {},
      ),
      SizedBox(height: 8.0),
      TextButton(
        onPressed: () {},
        child: Text('Not Registered yet?'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
