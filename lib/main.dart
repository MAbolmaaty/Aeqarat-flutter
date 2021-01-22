import 'package:aeqarat/src/screens/splash.dart';
import 'package:aeqarat/src/screens/welcomePage.dart';
import 'package:aeqarat/src/utils/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    String lang = instance.getString('Locale');
    if(lang == null) lang = 'en';
    runApp(App(lang));
  });
}

class App extends StatelessWidget {
  final String locale;

  App(this.locale);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppLocale(Locale(locale)),
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
            home: WelcomePage(),
          );
        },
      ),
    );
  }
}