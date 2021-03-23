import 'package:flutter/material.dart';

class AppLocale extends ChangeNotifier {
  Locale locale;

  AppLocale([this.locale]);

  void changeLocale(Locale newLocale) {
    if (newLocale == Locale('ar')) {
      locale = Locale('ar');
    } else {
      locale = Locale('en');
    }
    notifyListeners();
  }
}
