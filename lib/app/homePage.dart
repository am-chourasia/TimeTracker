import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("Error in Singing Out");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton(
              onPressed: _signOut,
              child: Text(
                "Log Out",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              )),
        ],
      ),
    );
  }
}