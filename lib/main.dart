import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:time_tracker/app/ladingPage.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/services/authProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
