import 'package:flutter/material.dart';
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
                    margin: EdgeInsets.only(right: 8.0, left: 8.0),
                      height: double.infinity,
                      child: Icon(
                        Icons.chevron_left,
                        color: const Color(0xffFEC200),
                        size: 32,
                      ))))),
      Align(
        alignment: Alignment.center,
        child: Text(
          _screenTitle,
          style: TextStyle(
              color: Colors.black, fontSize: 15,),
        ),
      ),
      Align(alignment: locale.locale == Locale('en') ? Alignment.centerRight : Alignment.centerLeft, child: _thirdAction,)
    ]));
  }
}
