
import 'package:aeqarat/src/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF9FBFC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Cairo',
      ),
      home: Splash(),
    );
  }
}

