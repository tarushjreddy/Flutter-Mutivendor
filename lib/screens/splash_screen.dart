import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/screens/SignIN/signin.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Null> timer;

  @override
  void initState() {
    navigateToAppropriateScreen();
    super.initState();
  }

  void navigateToAppropriateScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';

    timer = Future.delayed(Duration(seconds: 1), () {
      if (token == '') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyLogin()),
        );
      } else {
        print(token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
