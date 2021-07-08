import 'package:time_tracker/app/sign_in/valitdators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidator {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  String get primaryText => formType == EmailSignInFormType.signIn ? 'Sign In' : 'Create an account';
  String get secondaryText => formType == EmailSignInFormType.signIn ? 'Need an account? Register' : 'Have an account? Sign In';
  bool get canSubmit => emailValidator.isValid(email) && passwordValidator.isValid(password) && !isLoading;

  String get passwordError {
    bool showErrorText = submitted && !passwordValidator.isValid(password) && isLoading;
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailError {
    bool showErrorText = submitted && !emailValidator.isValid(email) && !isLoading;
    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) =>
      EmailSignInModel(
        email: email ?? this.email, // if left side is not null, email is assigned, otherwise this.email
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted,
      );
}
