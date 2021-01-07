
import 'dart:async';
import 'package:aeqarat/screens/welcomePage.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static final ROUTE = "Splash";

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amber,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    Timer(Duration(seconds: 3), nextScreen);
  }

  void nextScreen() {
    print("hhhhh");
    Navigator.of(context).pushReplacementNamed(WelcomePage.ROUTE);
  }
}
