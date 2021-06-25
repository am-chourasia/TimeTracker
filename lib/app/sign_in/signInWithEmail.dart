import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/emailSignInForm.dart';

class SignInWithEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign In")),
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: EmailForm(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
    return scaffold;
  }
}
