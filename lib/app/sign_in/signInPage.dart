import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/signInBloc.dart';
import 'package:time_tracker/app/sign_in/signInButton.dart';
import 'package:time_tracker/app/sign_in/signInWithEmail.dart';
import 'package:time_tracker/app/sign_in/socialSigInButton.dart';
import 'package:time_tracker/customWidgets/showExceptionAlertDialog.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  final bloc;

  static Widget create(BuildContext context) {
    // this function is to allow the landing page to directly create the widget without the provider and a SignIn constructor
    return Provider(
      create: (_) => SignInBloc(
        auth: Provider.of<AuthBase>(context, listen: false),
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) => SignInPage(bloc: bloc),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception e) {
    if (e is FirebaseException && e.code == "ERROR_ABORTED_BY_USER") return;
    // as thrown by the auth service when the user abort the singin
    showExceptionAlertDialog(
      context,
      exception: e,
      title: "Sign In Falied",
    );
  }

  Future<void> _signIn(BuildContext context, Future<void> Function() signInMethod) async {
    try {
      await signInMethod();
    } on Exception catch (e) {
      _showSignInError(context, e);
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
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          // no need to check for the snapshot.connectionState when the default value is provided
          return _buildContent(context, snapshot.data);
        },
      ),
      backgroundColor: Colors.grey[200],
    );
    return scaffold;
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    // underscore makes the method private, i.e. not accesible by other files
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: _buildHeader(context, isLoading),
          ),
          SizedBox(height: 40),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: "Sign In with Google",
            textColor: Colors.black,
            color: Colors.white,
            onPressed: isLoading
                ? null
                : () => _signIn(context, bloc.signInWithGoogle),
          ),
          SizedBox(height: 10),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: "Sign In with Facebook",
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: isLoading
                ? null
                : () => _signIn(context, bloc.signInWithFacebook),
          ),
          SizedBox(height: 10),
          SignInButton(
            text: "Sign In with Email",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: isLoading ? null : () => _signInWithEmail(context),
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
            onPressed: isLoading
                ? null
                : () => _signIn(context, bloc.signInAnonymously),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isLoading) {
    if (isLoading)
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
