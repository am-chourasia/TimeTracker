import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/emailSignInForm.dart';

class SignInWithEmailPage extends StatelessWidget {
  const SignInWithEmailPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        //IconButton as actions is temporary to center the text in appbar
        actions: [
          Opacity(
            opacity: 0.0,
            child: IconButton(
              icon: const Icon(Icons.cancel),
              tooltip: 'Show Snackbar',
              onPressed: () {},
            ),
          ),
        ],
        title: Center(child: Text("Sign In")),
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(auth: auth),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
    return scaffold;
  }
}
