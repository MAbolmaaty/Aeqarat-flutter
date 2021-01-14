import 'package:aeqarat/src/utils/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  @override
  _AdvancedSettingsScreenState createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  bool isLanguageListVisible = false;

  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<AppLocale>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              isLanguageListVisible
                  ? isLanguageListVisible = false
                  : isLanguageListVisible = true;
            }),
            child: Container(
              height: 60,
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.only(left: 25, right: 25),
              color: const Color(0x309e9e9e),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: locale.locale == Locale('en')
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context).language,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Align(
                      alignment: locale.locale == Locale('en')
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_right,
                        color: const Color(0xee9e9e9e),
                      )),
                ],
              ),
            ),
          ),
          Visibility(
              visible: isLanguageListVisible,
              child: GestureDetector(
                onTap: () => setState(() {
                  locale.changeLocale(Locale('ar'));
                  setValue('ar');
                }),
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: locale.locale == Locale('en')
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: locale.locale == Locale('ar')
                                ? Text(
                                    AppLocalizations.of(context).arabic,
                                    style: TextStyle(
                                      color: const Color(0xFFFFDB27),
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context).arabic,
                                    style: TextStyle(
                                      color: const Color(0xff9e9e9e),
                                    ),
                                  )),
                      ),
                      Align(
                        child: Padding(
                            padding: EdgeInsets.only(right: 25, left: 25),
                            child: locale.locale == Locale('ar')
                                ? Icon(
                                    Icons.check_circle,
                                    color: const Color(0xFFFFDB27),
                                  )
                                : Icon(
                                    Icons.check_circle,
                                    color: const Color(0x809e9e9e),
                                  )),
                        alignment: locale.locale == Locale('en')
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                      )
                    ],
                  ),
                ),
              )),
          Visibility(
              visible: isLanguageListVisible,
              child: GestureDetector(
                  onTap: () => setState(() {
                        locale.changeLocale(Locale('en'));
                        setValue('en');
                      }),
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                              padding: EdgeInsets.only(left: 25, right: 25),
                              child: locale.locale == Locale('en')
                                  ? Text(
                                      AppLocalizations.of(context).english,
                                      style: TextStyle(
                                        color: const Color(0xFFFFDB27),
                                      ),
                                    )
                                  : Text(AppLocalizations.of(context).english,
                                      style: TextStyle(
                                        color: const Color(0xff9e9e9e),
                                      ))),
                          alignment: locale.locale == Locale('en')
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                        ),
                        Align(
                          child: Padding(
                              padding: EdgeInsets.only(right: 25, left: 25),
                              child: locale.locale == Locale('en')
                                  ? Icon(
                                      Icons.check_circle,
                                      color: const Color(0xFFFFDB27),
                                    )
                                  : Icon(
                                      Icons.check_circle,
                                      color: const Color(0x809e9e9e),
                                    )),
                          alignment: locale.locale == Locale('en')
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                        )
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  setValue(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Locale', lang);
  }
}
