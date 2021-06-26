import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/customWidgets/customElevatedButton.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  // default type of form will be signIn

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmail(_email, _password);
      } else {
        await widget.auth.registerWithEmail(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print("Error in signing/registering with email");
      print(e.toString());
    }
  }

  void _toggleType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final _buttonText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
    final _alternativeText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign In';
    return [
      TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email_id@email.com',
        ),
        autocorrect: false,
        // to disable autocorrect in keyboard while typing email
        keyboardType: TextInputType.emailAddress,
        // to suggest emails while typing email
        textInputAction: TextInputAction.next,
        // to go to next field with enter in keyboard
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(_passwordFocusNode),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        // to hide the text
        textInputAction: TextInputAction.done,
        onEditingComplete: _submit,
      ),
      SizedBox(height: 30.0),
      CustomElevatedButton(
        child: Text(
          _buttonText,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: _submit,
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(_alternativeText),
        onPressed: _toggleType,
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
