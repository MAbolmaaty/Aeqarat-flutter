import 'package:flutter/material.dart';
//import 'file:///C:/MU/barq/lib/src/utils/localization/app_locale.dart';
import 'package:provider/provider.dart';

import '../utils/localization/app_locale.dart';

class ScreenAppBar extends StatelessWidget {
  bool _implyLeading;
  String _screenTitle;
  GestureDetector _thirdAction;

  ScreenAppBar(
      {screenTitle = "", implyLeading = false, GestureDetector thirdAction}) {
    this._implyLeading = implyLeading;
    this._screenTitle = screenTitle;
    this._thirdAction = thirdAction;
  }

  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<AppLocale>(context);
    return Expanded(
        child: Stack(children: [
      Visibility(
          visible: _implyLeading,
          child: Align(
              alignment: locale.locale == Locale('en') ? Alignment.centerLeft : Alignment.centerRight,
              child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      height: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.arrow_back,
                          color: const Color(0xffFEC200),
                        ),
                      ))))),
      Align(
        alignment: Alignment.center,
        child: Text(
          _screenTitle,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Cairo'),
        ),
      ),
      Align(alignment: locale.locale == Locale('en') ? Alignment.centerRight : Alignment.centerLeft, child: _thirdAction,)
    ]));
  }
}
