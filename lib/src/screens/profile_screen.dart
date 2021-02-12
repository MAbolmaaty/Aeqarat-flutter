import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:aeqarat/src/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacement(LoginScreen.route());
            },
            child: Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10, bottom: 10),
              child: Text(AppLocalizations.of(context).login),
              decoration: BoxDecoration(
                  color: const Color(0xFFFFDB27),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0))),
            ),
          ),
        ),
      ),
    );
  }

}