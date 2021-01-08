import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:aeqarat/src/utils/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppLocale(),
      child: Consumer<AppLocale>(
        builder: (context, locale, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale.locale,
            theme: ThemeData(
              primaryColor: const Color(0xFFF9FBFC),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Cairo',
            ),
            home: BottomNavScreen(),
          );
        },
      ),
    );
  }
}
