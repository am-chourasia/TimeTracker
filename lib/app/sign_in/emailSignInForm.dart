import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/valitdators.dart';
import 'package:time_tracker/customWidgets/formSubmitButton.dart';
import 'package:time_tracker/customWidgets/showExceptionAlertDialog.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  // default type of form will be signIn
  bool _submitted = false;
  bool _isLoading = false;

  // Look for if this method is needed or is creating problems
  @override
  void initState() {
    super.initState();
    // the below code is runned only once the widget is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
      // to auto focus on the email field on the new page
    });
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    // We don't need explicit passing of context for Statefull Widgets mehtods
    setState(() {
      _isLoading = true;
      _submitted = true;
    });
    try {
      // await Future.delayed(Duration(seconds: 5));
      // Artificial delay to test for slow network
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmail(_email, _password);
      } else {
        await auth.registerWithEmail(_email, _password);
      }
      Navigator.of(context).pop();
      // to return to the previous screen
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign In Failed",
        exception: e,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleType() {
    setState(() {
      _submitted = false;
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
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
    return [
      _buildEmailField(),
      SizedBox(height: 8.0),
      _buildPasswordField(),
      SizedBox(height: 30.0),
      FormSubmitButton(
        text: _buttonText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(_alternativeText),
        onPressed: _isLoading == true ? null : _toggleType,
      )
    ];
  }

  void _emailEditingComplete() {
    final newFocusNode = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocusNode);
  }

  Widget _buildEmailField() {
    bool showErrorText =
        _submitted && !widget.emailValidator.isValid(_email) && !_isLoading;
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email_id@email.com',
        enabled: _isLoading == false,
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      // to disable autocorrect in keyboard while typing email
      keyboardType: TextInputType.emailAddress,
      // to suggest emails while typing email
      textInputAction: TextInputAction.next,
      // to go to next field with enter in keyboard
      onChanged: (email) => _rebuildWidget(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  Widget _buildPasswordField() {
    bool showErrorText = _submitted &&
        !widget.passwordValidator.isValid(_password) &&
        !_isLoading;
    // show error when the form is _submitted atleast once and then the field is empty
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        enabled: _isLoading == false,
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      obscureText: true,
      // to hide the text
      textInputAction: TextInputAction.done,
      onChanged: (password) => _rebuildWidget(),
      onEditingComplete: _submit,
    );
  }

  void _rebuildWidget() {
    // to rebuild the widget so that the update in the submit button is enabled
    setState(() {});
    // setState rebuilds the widget everytime it is called, i.e. calls build metchod of the widget
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
