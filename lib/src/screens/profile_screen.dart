import 'dart:io';

import 'package:aeqarat/src/utils/networking/authentication_api.dart';
import 'package:aeqarat/src/utils/preferences/user_preferences.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = new GlobalKey<FormState>();
  File imageFile;
  String profilePicture, _username, _email, _phoneNumber;
  TextEditingController _controllerUsername;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPhoneNumber;

  @override
  void initState() {
    super.initState();
    UserPreferences().getUser().then((user) {
      setState(() {
        profilePicture = user.profilePicture.url;
        _username = user.username;
        _controllerUsername = TextEditingController(text: _username);
        _email = user.email;
        _controllerEmail = TextEditingController(text: _email);
        _phoneNumber = user.phoneNumber;
        _controllerPhoneNumber = TextEditingController(text: _phoneNumber);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences().getUser().then((user) {
      if (_username == null) {
        setState(() {
          profilePicture = user.profilePicture.url;
          _username = user.username;
          _controllerUsername = TextEditingController(text: _username);
          _email = user.email;
          _controllerEmail = TextEditingController(text: _email);
          _phoneNumber = user.phoneNumber;
          _controllerPhoneNumber = TextEditingController(text: _phoneNumber);
        });
      }
    });
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewPortConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewPortConstraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ////////////////////// Profile Picture
                      GestureDetector(
                          onTap: () {
                            // _showChoiceDialog(context).then((value) =>
                            //     authenticationApi
                            //         .profilePictureUploaded(true));
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
                                              profilePicture != null
                                                  ? NetworkImage(profilePicture)
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
                              ]))),
                      ///////////////////////////////// Username
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _controllerUsername,
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
                          controller: _controllerEmail,
                          validator: (value) => value.isEmpty
                              ? AppLocalizations.of(context).enterEmail
                              : null,
                          //onSaved: (value) => _email = value,
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
                      /////////////////////////// Phone Number
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _controllerPhoneNumber,
                          validator: (value) => value.isEmpty
                              ? AppLocalizations.of(context).enterPhoneNumber
                              : null,
                          //onSaved: (value) => _phoneNumber = value,
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
                      ///////////////////// LogOut
                      Consumer<AuthenticationApi>(
                          builder: (context, authenticationApi, child) {
                        return GestureDetector(
                          onTap: (){
                            authenticationApi.logout();
                          },
                          child: Container(
                            child: authenticationApi.authenticationStatus ==
                                    Authentication.LoggingOut
                                ? _loading()
                                : Text(
                                    AppLocalizations.of(context).logout),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                color: const Color(0xffFFDB27)),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
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
}
