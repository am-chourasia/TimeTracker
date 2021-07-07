import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/emailSignInModel.dart';
import 'package:time_tracker/app/sign_in/emailSignInBloc.dart';
import 'package:time_tracker/app/sign_in/valitdators.dart';
import 'package:time_tracker/customWidgets/formSubmitButton.dart';
import 'package:time_tracker/customWidgets/showExceptionAlertDialog.dart';

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  EmailSignInForm({Key key, @required this.bloc}) : super(key: key);
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInForm(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

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

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop(); // to return to the previous screen
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign In Failed",
        exception: e,
      );
    }
  }

  void _toggleType(EmailSignInModel model) {
    widget.bloc.updateWith(
      email: '',
      password: '',
      formType: model.formType == EmailSignInFormType.signIn ? EmailSignInFormType.register : EmailSignInFormType.signIn,
      isLoading: false,
      submitted: false,
    );
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    final _buttonText = model.formType == EmailSignInFormType.signIn ? 'Sign In' : 'Create an account';
    final _alternativeText = model.formType == EmailSignInFormType.signIn ? 'Need an account? Register' : 'Have an account? Sign In';
    bool submitEnabled = widget.emailValidator.isValid(model.email) && widget.passwordValidator.isValid(model.password) && !model.isLoading;
    return [
      _buildEmailField(model),
      SizedBox(height: 8.0),
      _buildPasswordField(model),
      SizedBox(height: 30.0),
      SizedBox(
        height: 50,
        child: _buildButton(context, model, _buttonText, submitEnabled),
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(_alternativeText),
        onPressed: model.isLoading == true ? null : () => _toggleType(model),
      )
    ];
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocusNode = widget.emailValidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocusNode);
  }

  Widget _buildEmailField(EmailSignInModel model) {
    bool showErrorText = model.submitted && !widget.emailValidator.isValid(model.email) && !model.isLoading;
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email_id@email.com',
        enabled: model.isLoading == false,
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      // to disable autocorrect in keyboard while typing email
      keyboardType: TextInputType.emailAddress,
      // to suggest emails while typing email
      textInputAction: TextInputAction.next,
      // to go to next field with enter in keyboard
      onChanged: (email) => widget.bloc.updateWith(email: email),
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  Widget _buildPasswordField(EmailSignInModel model) {
    bool showErrorText = model.submitted && !widget.passwordValidator.isValid(model.password) && !model.isLoading;
    // show error when the form is _submitted atleast once and then the field is empty
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        enabled: model.isLoading == false,
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      obscureText: true,
      // to hide the text
      textInputAction: TextInputAction.done,
      onChanged: (password) => widget.bloc.updateWith(password: password),
      onEditingComplete: _submit,
    );
  }

  Widget _buildButton(BuildContext context, EmailSignInModel model, String buttonText, bool submitEnabled) {
    if (model.isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return FormSubmitButton(
      text: buttonText,
      onPressed: submitEnabled ? _submit : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot) {
        final model = snapshot.data;
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(model),
          ),
        );
      },
    );
  }
}
