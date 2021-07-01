import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/signInButton.dart';
import 'package:time_tracker/app/sign_in/signInWithEmail.dart';
import 'package:time_tracker/app/sign_in/socialSigInButton.dart';
import 'package:time_tracker/customWidgets/showExceptionAlertDialog.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _toggleLoadingState() {
    setState(() {
      _isLoading = _isLoading ? false : true;
    });
  }

  void _showSignInError(BuildContext context, Exception e) {
    if (e is FirebaseException && e.code == "ERROR_ABORTED_BY_USER") return;
    // as thrown by the auth service
    showExceptionAlertDialog(
      context,
      exception: e,
      title: "Sign In Falied",
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    _toggleLoadingState();
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInAnonymously();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      _toggleLoadingState();
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    _toggleLoadingState();
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      _toggleLoadingState();
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    _toggleLoadingState();
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      _showSignInError(context, e);
    } finally {
      _toggleLoadingState();
    }
  }

  void _signInWithEmail(BuildContext context) {
    _toggleLoadingState();
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => SignInWithEmailPage(),
      ),
    );
    _toggleLoadingState();
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
          SizedBox(
            height: 50,
            child: _buildHeader(context),
          ),
          SizedBox(height: 40),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: "Sign In with Google",
            textColor: Colors.black,
            color: Colors.white,
            onPressed: _isLoading ? () {} : () => _signInWithGoogle(context),
          ),
          SizedBox(height: 10),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: "Sign In with Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: _isLoading ? () {} : () => _signInWithFacebook(context),
          ),
          SizedBox(height: 10),
          SignInButton(
            text: "Sign In with Email",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: _isLoading ? () {} : () => _signInWithEmail(context),
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
            onPressed: _isLoading ? () {} : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (_isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
