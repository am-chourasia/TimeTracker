import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/customWidgets/showAlertDialog.dart';

class HomePage extends StatelessWidget {
  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmation = await showAlertDialog(
      context,
      title: "Log Out",
      content: "Are you sure you want to log out?",
      cancelActionText: "Cancel",
      defaultActionText: "Log Out",
    );
    if (confirmation == true) _signOut(context);
  }

  Future<void> _signOut(context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
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
              onPressed: () => _confirmSignOut(context),
              child: Text(
                "Log Out",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              )),
        ],
      ),
    );
  }
}
