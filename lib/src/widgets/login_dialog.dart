import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:aeqarat/src/screens/bottom_nav_screen.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          AppLocalizations.of(context).loginToProceed,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Row(
          children: <Widget>[
            ////////////////////////////////// Save
            Expanded(
              child: Container(
                height: 48.0,
                child: RaisedButton(
                  color: const Color(0xffFFDB27),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(BottomNavScreen.route(1, false));},
                  child: Text(
                    AppLocalizations.of(context).login,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            /////////////////////////// Cancel
            Expanded(
              child: Container(
                height: 48.0,
                child: RaisedButton(
                  color: const Color(0xffECECEC),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context).cancel,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
