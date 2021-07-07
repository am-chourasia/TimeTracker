import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/emailSignInForm.dart';

class SignInWithEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //IconButton as actions is temporary to center the text in appbar
        actions: [
          Opacity(
            opacity: 0.0,
            child: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {},
              // below code is to disable splash effect on the icon
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ),
        ],
        title: Center(child: Text("Sign In")),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
