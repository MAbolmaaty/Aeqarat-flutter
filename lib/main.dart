import 'package:aeqarat/route/route.dart';
import 'package:aeqarat/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.ROUTE,
      routes: routes,
    );
  }
}

