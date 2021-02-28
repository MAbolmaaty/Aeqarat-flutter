import 'package:aeqarat/src/models/authentication_response_model.dart';
import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:aeqarat/src/screens/registerScreen.dart';
import 'package:aeqarat/src/utils/networking/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static Route<dynamic> route({bool implyLeading, String realEstateId}) =>
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          implyLeading: implyLeading,
          realEstateId: realEstateId,
        ),
      );

  final formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool _passwordVisible = false;
  final bool implyLeading;
  final String realEstateId;

  LoginScreen({this.implyLeading, this.realEstateId});

  @override
  Widget build(BuildContext context) {
    String _identifier, _password;
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
                        padding: const EdgeInsets.only(
                            top: 56.0, right: 16, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: implyLeading,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  color: const Color(0xffFEC200),
                                  size: 32,
                                ),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).login,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.99,
                        height: MediaQuery.of(context).size.height * 0.27,
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: ExactAssetImage("assets/images/4.png"),
                                fit: BoxFit.scaleDown)),
                      ),
                      ///////////////////////////////// Identifier
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextFormField(
                          maxLines: 1,
                          validator: (value) => value.isEmpty
                              ? AppLocalizations.of(context)
                                  .enterEmailOrPhoneNumber
                              : null,
                          onSaved: (value) => _identifier = value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 11, bottom: 11, left: 16, right: 16),
                              labelText: AppLocalizations.of(context)
                                  .emailOrPhoneNumber,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ///////////////// Remember Me
                                Checkbox(
                                  value: rememberMe,
                                  //onChanged: _onRememberMeChanged,
                                  activeColor: Colors.grey.withOpacity(0.6),
                                  checkColor: const Color(0xffFFDB27),
                                ),
                                Text(
                                  AppLocalizations.of(context).rememberMe,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            ///////////////// Forget Password
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                AppLocalizations.of(context).forgetPassword,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /////////////////////////// Login
                      Consumer<AuthenticationApi>(
                          builder: (context, authenticationApi, child) {
                        return GestureDetector(
                            onTap: () {
                              //// Hide keyboard
                              FocusScope.of(context).unfocus();
                              final form = formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                authenticationApi
                                    .login(_identifier, _password)
                                    .then((result) {
                                  if (result['status']) {
                                    AuthenticationResponseModel
                                        authenticationResponseModel =
                                        result['data'];
                                    saveApiToken(
                                            authenticationResponseModel.jwt)
                                        .then((value) {
                                      if (value) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                BottomNavScreen.route(
                                                    currentIndex: 2,
                                                    realEstateId: realEstateId),
                                                (route) => false);
                                      }
                                    });
                                  }
                                });
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
                                      BorderRadius.all(Radius.circular(16.0)),
                                  color: const Color(0xffFFDB27)),
                              child: authenticationApi.loggedInStatus ==
                                      Status.LoggingIn
                                  ? _loading()
                                  : Text(
                                      AppLocalizations.of(context).login,
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
                      /////////////////////////// Create new account
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).doNotHaveAccount,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(RegisterScreen.route());
                              },
                              child: Text(
                                AppLocalizations.of(context).createAccount,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
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
