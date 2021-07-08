import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/emailSignInModel.dart';
import 'package:time_tracker/app/sign_in/emailSignInBloc.dart';
import 'package:time_tracker/customWidgets/formSubmitButton.dart';
import 'package:time_tracker/customWidgets/showExceptionAlertDialog.dart';

class EmailSignInForm extends StatefulWidget {
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

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocusNode = model.emailValidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocusNode);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailField(model),
      SizedBox(height: 8.0),
      _buildPasswordField(model),
      SizedBox(height: 30.0),
      SizedBox(
        height: 50,
        child: _buildButton(context, model),
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(model.secondaryText),
        onPressed: model.isLoading == true ? null : _toggleFormType,
      )
    ];
  }

  Widget _buildEmailField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email_id@email.com',
        enabled: model.isLoading == false,
        errorText: model.emailError,
      ),
      autocorrect: false, // to disable autocorrect in keyboard while typing email
      keyboardType: TextInputType.emailAddress, // to suggest emails while typing email
      textInputAction: TextInputAction.next, // to go to next field with enter in keyboard
      onChanged: (email) => widget.bloc.updateWith(email: email),
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  Widget _buildPasswordField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        enabled: model.isLoading == false,
        errorText: model.passwordError,
      ),
      obscureText: true,
      // to hide the text
      textInputAction: TextInputAction.done,
      onChanged: (password) => widget.bloc.updateWith(password: password),
      onEditingComplete: _submit,
    );
  }

  Widget _buildButton(BuildContext context, EmailSignInModel model) {
    if (model.isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    return FormSubmitButton(
      text: model.primaryText,
      onPressed: model.canSubmit ? _submit : null,
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
