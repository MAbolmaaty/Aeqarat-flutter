
import 'dart:async';
import 'package:aeqarat/src/screens/welcomePage.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {

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
    Navigator.of(context).pushReplacement(WelcomePage.route(),);
  }
}
