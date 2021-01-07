
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static final ROUTE = "WelcomePage";
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcomeg"),
      ),
    );
  }
}
