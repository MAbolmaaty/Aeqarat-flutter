import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:aeqarat/src/screens/on_boarding_screen.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/utils/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    String lang = instance.getString('Locale');
    bool autoSkipping = instance.getBool('auto_skipping') ?? false;
    runApp(App(lang, autoSkipping));
  });
}

class App extends StatelessWidget {
  final String lang;
  final bool autoSkipping;

  App(this.lang, this.autoSkipping);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => lang == null ? AppLocale() : AppLocale(Locale(lang)),
      child: Consumer<AppLocale>(
        builder: (context, locale, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale.locale,
            theme: ThemeData(
              primaryColor: const Color(0xFFF9FBFC),
              accentColor: Colors.black,
              colorScheme: ColorScheme.light(primary: AppTheme.primaryColor),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Cairo',
            ),
            home: autoSkipping
                ? BottomNavScreen(currentIndex: 2,)
                : OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
