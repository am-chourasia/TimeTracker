import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/authProvider.dart';
import 'package:time_tracker/app/sign_in/signInButton.dart';
import 'package:time_tracker/app/sign_in/signInWithEmail.dart';
import 'package:time_tracker/app/sign_in/socialSigInButton.dart';

class SignInPage extends StatelessWidget {
  
  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = AuthProvider.of(context);
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print("Error in Singing In Anonymously");
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = AuthProvider.of(context);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print("Error in Singing In with Google");
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final auth = AuthProvider.of(context);
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print("Error in Singing In with Facebook");
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => SignInWithEmailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Time Tracker")),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
    return scaffold;
  }

  Widget _buildContent(BuildContext context) {
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
            onPressed: () => _signInWithGoogle(context),
          ),
          SizedBox(height: 10),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: "Sign In with Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () => _signInWithFacebook(context),
          ),
          SizedBox(height: 10),
          SignInButton(
            text: "Sign In with Email",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
