
import 'package:aeqarat/scenes/splash/splash.dart';
import 'package:aeqarat/scenes/welcomePage/welcomePage.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Splash.ROUTE: (context) => Splash(),
  WelcomePage.ROUTE:(context) => WelcomePage(),
};
