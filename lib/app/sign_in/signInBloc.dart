import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'; // for the User type
import 'package:flutter/material.dart'; // for the required annotation
import 'package:time_tracker/app/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final StreamController<bool> _isLoading = StreamController<bool>();
  final AuthBase auth;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  void dispose() {
    _isLoading.close();
  }

  void _setIsLoading(bool isLoading) {
    // _isLoading.sink.add(isLoading); ask the community about the differece
    _isLoading.add(isLoading);
  }

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      print("Here is the problem");
      rethrow; // to rethrow the exception to the parent widget
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}
