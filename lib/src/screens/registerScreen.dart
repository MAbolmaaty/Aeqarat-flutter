import 'dart:io';

import 'package:aeqarat/src/screens/loginScreen.dart';
import 'package:aeqarat/src/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'bottom_nav_screen.dart';

class RegisterScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => RegisterScreen(),
  );

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool rememberMe = false;
  bool _passwordVisible ;
  File imageFile;
  _openGallery(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async{
    var camera = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = camera;
    });
    Navigator.of(context).pop();
  }
  Future <void> _showChoiceDialog(BuildContext  context){
    return showDialog(context: context ,builder:  (BuildContext context) {
    return AlertDialog(
      title: Text("Make a Choice"),
      content: SingleChildScrollView(
        child:  ListBody(
          children: [
            GestureDetector(
              child: Text("Gallary"),
              onTap: (){
                _openGallery(context);
              },
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            GestureDetector(
              child: Text("Camera"),
              onTap: (){
                _openCamera(context);
              },
            ),
          ],
        ),
      ) ,
    );
    });
  }
  // Future getImagefromCamera() async{
  //
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _image = image;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;

  }
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
                    AppLocalizations.of(context).createNewAccount,
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
                    AppLocalizations.of(context).workknowledge,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  )),
            ),
            Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
          child: InkWell(
            onTap: (){_showChoiceDialog(context);},
            child: CircleAvatar(
              // backgroundColor: Colors.grey,
              radius: 40.0,
              child: CircleAvatar(
                radius: 38.0,
                child: ClipOval(
                  child: (imageFile != null)
                      ? Image.file(imageFile)
                      : Image.asset('assets/images/5.png'),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    // hintText: AppLocalizations.of(context).email,
                    labelText: AppLocalizations.of(context).name,
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
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.emailAddress,
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
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    // hintText: AppLocalizations.of(context).email,
                    labelText: AppLocalizations.of(context).password,
                    labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;

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
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    // hintText: AppLocalizations.of(context).email,
                    labelText: AppLocalizations.of(context).confirmPassword,
                    labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;

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
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).phone,
                    labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    prefixIcon: CountryCodePicker(
                      onChanged: (code) {
                        print("on init ${code.name} ${code.dialCode} ");
                      },
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      showFlag: false,
                      showFlagDialog: true,
                    ) ,
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
                  keyboardType: TextInputType.phone,

                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(right:8.0 ,left: 8.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

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


                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).terms,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ) ,
                      InkWell(
                        onTap: (){
                          print("to view");
                        },

                        child: Text(
                          AppLocalizations.of(context).toView,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
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
                    AppLocalizations.of(context).newAccount,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  AppLocalizations.of(context).haveAccount,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                InkWell(
                  onTap: (){
                    print("forget");

                    Navigator.of(context).push(LoginScreen.route());

                  },
                  child: Text(
                    AppLocalizations.of(context).login,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ) ,
          ],
        ),
      ),
    );
  }


}
