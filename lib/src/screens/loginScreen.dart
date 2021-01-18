import 'package:aeqarat/src/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bottom_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool _secureText = true ;
bool rememberMe = false;

void _onRememberMeChanged(bool newValue) => setState(() {
  rememberMe = newValue;

  if (rememberMe) {
    // TODO: Here goes your functionality that remembers the user.
  } else {
    // TODO: Forget the user
  }
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    AppLocalizations.of(context).login,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    AppLocalizations.of(context).welcomeBack,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.99,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/4.png"),
                      fit: BoxFit.scaleDown)),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 0.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    // hintText: AppLocalizations.of(context).email,
                    labelText: AppLocalizations.of(context).email,
                    labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    // hintText: AppLocalizations.of(context).email,
                    labelText: AppLocalizations.of(context).password,
                    labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(_secureText ? Icons.remove_red_eye :Icons.security),
                      onPressed: (){
                        setState(() {
                          _secureText = !_secureText;
                        });
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Checkbox(
                              value: rememberMe,
                              onChanged: _onRememberMeChanged
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).rememberMe,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ) ,
                    ],
                  ),


                  InkWell(
                    onTap: (){
                      print("forget");
                    },
                    child: Text(
                      AppLocalizations.of(context).forgetPassword,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ) ,
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.99,

              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 8.0),
              child:  RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    // side: BorderSide(color: Colors.red)
                ),
                child:  Text(
                    AppLocalizations.of(context).login,
                    style:  TextStyle(
                      color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)
                ),
                colorBrightness: Brightness.dark,
                onPressed: () {
                  print("Save");
                  Navigator.of(context).pushReplacement(BottomNavScreen.route());

                },
                color: Colors.yellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 70.0, right: 70.0, top: 8.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).or,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 40,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    AppLocalizations.of(context).noAccount,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  InkWell(
                    onTap: (){
                      print("forget");
                    },
                    child: Text(
                      AppLocalizations.of(context).createAccount,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ) ,

          ],
        ),
      ),
    );
  }
}
