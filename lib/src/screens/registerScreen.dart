import 'dart:io';

import 'package:aeqarat/src/screens/login_screen.dart';
import 'package:aeqarat/src/utils/networking/authentication_api.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'accountDetails.dart';

class RegisterScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      );

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  File _selectedImage;

  //bool rememberMe = false;
  bool _passwordVisible;

  File imageFile;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var camera = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = camera;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationApi(),
      child: Scaffold(
        backgroundColor: const Color(0xffF9FBFC),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewPortConstraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 56.0, right: 16.0, left: 16.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context).createNewAccount,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      ///////////////////////// Profile Picture
                      GestureDetector(
                          onTap: () {
                            //getImage();
                            _showChoiceDialog(context);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 150,
                              width: 150,
                              child: Stack(children: <Widget>[
                                Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: const Color(0x109e9e9e),
                                      child: CircleAvatar(
                                          radius: 62,
                                          backgroundColor:
                                              const Color(0x109e9e9e),
                                          backgroundImage:
                                              imageFile != null
                                                  ? FileImage(imageFile)
                                                  : AssetImage(
                                                      'assets/images/profile.png',
                                                    )),
                                    )),
                                Visibility(
                                    visible:
                                        imageFile != null ? false : true,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                              padding: EdgeInsets.all(6),
                                              child: Image.asset(
                                                'assets/images/camera.png',
                                              ))),
                                    )),
                              ]))),
                      ///////////////////////////////// Username
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          // validator: (value) => value.isEmpty
                          //     ? AppLocalizations.of(context)
                          //     .enterEmailOrPhoneNumber
                          //     : null,
                          // onSaved: (value) => _identifier = value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 11, bottom: 11, left: 16, right: 16),
                              labelText: AppLocalizations.of(context).username,
                              labelStyle: TextStyle(
                                color: const Color(0xFF9e9e9e),
                                fontSize: 13,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              isDense: true),
                        ),
                      ),
                      ///////////////////////////////// Email Address
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          // validator: (value) => value.isEmpty
                          //     ? AppLocalizations.of(context)
                          //     .enterEmailOrPhoneNumber
                          //     : null,
                          // onSaved: (value) => _identifier = value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 11, bottom: 11, left: 16, right: 16),
                              labelText: AppLocalizations.of(context).email,
                              labelStyle: TextStyle(
                                color: const Color(0xFF9e9e9e),
                                fontSize: 13,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              isDense: true),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      ///////////////////////////// Password
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Consumer<AuthenticationApi>(
                            builder: (context, authenticationApi, child) {
                          return TextFormField(
                            maxLines: 1,
                            // validator: (value) => value.isEmpty
                            //     ? AppLocalizations.of(context).enterPassword
                            //     : null,
                            // onSaved: (value) => _password = value,
                            obscureText: authenticationApi.passwordVisibility ==
                                PasswordVisibility.PasswordHidden,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 11, bottom: 11, left: 16, right: 16),
                                labelText:
                                    AppLocalizations.of(context).password,
                                labelStyle: TextStyle(
                                  color: const Color(0xFF9e9e9e),
                                  fontSize: 13,
                                ),
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    authenticationApi.passwordVisibility ==
                                            PasswordVisibility.PasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xffE3E3E6),
                                    size: 25,
                                  ),
                                  onTap: () {
                                    authenticationApi
                                        .changePasswordVisibility();
                                  },
                                ),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffE3E3E6))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffE3E3E6))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffE3E3E6))),
                                isDense: true),
                          );
                        }),
                      ),
                      ///////////////////////////// Password Confirmation
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Consumer<AuthenticationApi>(
                            builder: (context, authenticationApi, child) {
                          return TextFormField(
                            maxLines: 1,
                            // validator: (value) => value.isEmpty
                            //     ? AppLocalizations.of(context).enterPassword
                            //     : null,
                            // onSaved: (value) => _password = value,
                            obscureText: authenticationApi.passwordVisibility ==
                                PasswordVisibility.PasswordHidden,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 11, bottom: 11, left: 16, right: 16),
                                labelText: AppLocalizations.of(context)
                                    .confirmPassword,
                                labelStyle: TextStyle(
                                  color: const Color(0xFF9e9e9e),
                                  fontSize: 13,
                                ),
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    authenticationApi.passwordVisibility ==
                                            PasswordVisibility.PasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xffE3E3E6),
                                    size: 25,
                                  ),
                                  onTap: () {
                                    authenticationApi
                                        .changePasswordVisibility();
                                  },
                                ),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffE3E3E6))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffE3E3E6))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffE3E3E6))),
                                isDense: true),
                          );
                        }),
                      ),
                      /////////////////////////// Phone Number
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          // validator: (value) => value.isEmpty
                          //     ? AppLocalizations.of(context)
                          //     .enterEmailOrPhoneNumber
                          //     : null,
                          // onSaved: (value) => _identifier = value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 11, bottom: 11, left: 16, right: 16),
                              labelText:
                                  AppLocalizations.of(context).phoneNumber,
                              labelStyle: TextStyle(
                                color: const Color(0xFF9e9e9e),
                                fontSize: 13,
                              ),
                              prefixIcon: CountryCodePicker(
                                onChanged: (code) {
                                },
                                initialSelection: 'SA',
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                showFlag: false,
                                showFlagDialog: true,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: const Color(0xffE3E3E6))),
                              isDense: true),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      ///////////////////////////// Register
                      Consumer<AuthenticationApi>(
                          builder: (context, authenticationApi, child) {
                            return GestureDetector(
                                onTap: () {
                                  final form = formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                      color: const Color(0xffFFDB27)),
                                  child: Text(
                                    AppLocalizations.of(context).register,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ));
                          }),
                      //////////////////////////// OR
                      Expanded(
                        child: Padding(
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
                                    fontSize: 13,
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
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).alreadyHaveAccount,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            InkWell(
                              onTap: () {
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future getImage() async {
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    //   if (pickedFile != null) {
    //     _selectedImage = File(pickedFile.path);
    //   }
    // });
  }
}
