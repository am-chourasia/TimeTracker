import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/emailSignInModel.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel(); // this will represent the latest model added to the stream

  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    // update model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    // add updated _modelController
    _modelController.add(_model);
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      // await Future.delayed(Duration(seconds: 5));
      // Artificial delay to test for slow network
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmail(_model.email, _model.password);
      } else {
        await auth.registerWithEmail(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
