import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/services/auth.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({@required this.child, @required this.auth});
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    AuthProvider provider = context.dependOnInheritedWidgetOfExactType();
    return provider.auth;
  }
}
