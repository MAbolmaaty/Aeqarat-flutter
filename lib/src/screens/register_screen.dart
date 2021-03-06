import 'dart:io';

import 'package:aeqarat/src/models/authentication_response_model.dart';
import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/utils/networking/authentication_api.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  static Route<dynamic> route({String realEstateId}) => MaterialPageRoute(
        builder: (context) => RegisterScreen(
          realEstateId: realEstateId,
        ),
      );

  final formKey = GlobalKey<FormState>();
  final sKey = GlobalKey<ScaffoldState>();
  String _username, _email, _password, _confirmPassword, _phoneNumber;
  File imageFile;
  final String realEstateId;

  RegisterScreen({this.realEstateId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationApi(),
      child: Scaffold(
        key: sKey,
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 0.0,
          backgroundColor: Colors.transparent,
        ),
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
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.chevron_left,
                                color: const Color(0xffFEC200),
                                size: 32,
                              ),
                            ),
                            SizedBox(width: 8.0,),
                            Text(
                              AppLocalizations.of(context).createNewAccount,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ///////////////////////// Profile Picture
                      Consumer<AuthenticationApi>(
                          builder: (context, authenticationApi, child) {
                        return GestureDetector(
                            onTap: () {
                              _showChoiceDialog(context).then((value) =>
                                  authenticationApi
                                      .profilePictureUploaded(true));
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
                                        backgroundColor:
                                            const Color(0x109e9e9e),
                                        child: CircleAvatar(
                                            radius: 62,
                                            backgroundColor:
                                                const Color(0x109e9e9e),
                                            backgroundImage: imageFile != null
                                                ? FileImage(imageFile)
                                                : AssetImage(
                                                    'assets/images/profile.png',
                                                  )),
                                      )),
                                  Visibility(
                                      visible: imageFile != null ? false : true,
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
                                ])));
                      }),
                      ///////////////////////////////// Username
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          validator: (value) => value.isEmpty
                              ? AppLocalizations.of(context).enterUsername
                              : null,
                          onSaved: (value) => _username = value,
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
                          validator: (value) => value.isEmpty
                              ? AppLocalizations.of(context).enterEmail
                              : null,
                          onSaved: (value) => _email = value,
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
                            validator: (value) => value.isEmpty
                                ? AppLocalizations.of(context).enterPassword
                                : null,
                            onSaved: (value) => _password = value,
                            obscureText:
                                authenticationApi.registerPasswordVisibility ==
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
                                    authenticationApi
                                                .registerPasswordVisibility ==
                                            PasswordVisibility.PasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xffE3E3E6),
                                    size: 25,
                                  ),
                                  onTap: () {
                                    authenticationApi
                                        .changeRegisterPasswordVisibility();
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
                      ///////////////////////////// Confirm Password
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Consumer<AuthenticationApi>(
                            builder: (context, authenticationApi, child) {
                          return TextFormField(
                            maxLines: 1,
                            validator: (value) => value.isEmpty
                                ? AppLocalizations.of(context)
                                    .pleaseConfirmPassword
                                : null,
                            onSaved: (value) => _confirmPassword = value,
                            obscureText: authenticationApi
                                    .registerConfirmPasswordVisibility ==
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
                                    authenticationApi
                                                .registerConfirmPasswordVisibility ==
                                            PasswordVisibility.PasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xffE3E3E6),
                                    size: 25,
                                  ),
                                  onTap: () {
                                    authenticationApi
                                        .changeRegisterConfirmPasswordVisibility();
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
                          validator: (value) => value.isEmpty
                              ? AppLocalizations.of(context).enterPhoneNumber
                              : null,
                          onSaved: (value) => _phoneNumber = value,
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
                                onChanged: (code) {},
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
                              //// Hide keyboard
                              FocusScope.of(context).unfocus();
                              final form = formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                if (_password == _confirmPassword) {
                                  authenticationApi
                                      .register(
                                          _username,
                                          _email,
                                          _password,
                                          _confirmPassword,
                                          _phoneNumber,
                                          imageFile)
                                      .then((result) {
                                    if (result['status']) {
                                      AuthenticationResponseModel
                                          authenticationResponseModel =
                                          result['data'];
                                      saveApiToken(
                                              authenticationResponseModel.jwt)
                                          .then((value) {
                                        if (value)
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  BottomNavScreen.route(
                                                      currentIndex: 2,
                                                      realEstateId:
                                                          realEstateId),
                                                  (route) => false);
                                      });
                                    }
                                  });
                                } else {
                                  sKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)
                                          .passwordsDoNotMatch,
                                    ),
                                  ));
                                }
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
                              child: authenticationApi.registeredStatus ==
                                      Status.Registering
                                  ? _loading()
                                  : Text(
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
                      //////////////////////////////// Login
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).alreadyHaveAccount,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context).login,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
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

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var camera = await ImagePicker().getImage(source: ImageSource.camera);
    imageFile = File(camera.path);
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

  Widget _loading() {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
            backgroundColor: const Color(0xffFFDB27),
            strokeWidth: 2,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)),
        height: 20,
        width: 20,
      ),
    );
  }

  Future<bool> saveApiToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString('api_token', token);
  }
}
