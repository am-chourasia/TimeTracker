import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/signInButton.dart';
import 'package:time_tracker/app/sign_in/social_sigin_button.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Center(child: Text("First App")),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
    return scaffold;
  }
}

Widget _buildContent() {
  // underscore makes the method private, i.e. not accesible by other files
  return Padding(
    padding: EdgeInsets.all(30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Sign In',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 40),
        SocialSignInButton(
          assetName: 'images/google-logo.png',
          text: "Sign In with Google",
          textColor: Colors.black,
          color: Colors.white,
          onPressed: () {},
        ),
        SizedBox(height: 10),
        SocialSignInButton(
          assetName: 'images/facebook-logo.png',
          text: "Sign In with Facebook",
          textColor: Colors.white,
          color: Color(0xFF334D92),
          onPressed: () {},
        ),
        SizedBox(height: 10),
        SignInButton(
          text: "Sign In with Email",
          textColor: Colors.white,
          color: Colors.teal[700],
          onPressed: () {},
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            "or",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        SizedBox(height: 20),
        SignInButton(
          text: "Go Anonymous",
          textColor: Colors.white,
          color: Colors.grey[700],
          onPressed: () {},
        ),
      ],
    ),
  );
}
