import 'dart:convert';

import 'package:aeqarat/src/models/authentication_response_model.dart';
import 'package:aeqarat/src/utils/networking/app_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
}

enum PasswordVisibility {
  PasswordVisible,
  PasswordHidden,
}

class AuthenticationApi with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  PasswordVisibility _passwordVisibility = PasswordVisibility.PasswordHidden;

  Status get loggedInStatus => _loggedInStatus;
  PasswordVisibility get passwordVisibility => _passwordVisibility;

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    var result;

    final Map<String, dynamic> requestBody = {
      'identifier': identifier,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Map<String, String> headers = {"Content-Type": "application/json"};

    Response response = await post(AppUrl.login_url,
        headers: headers, body: json.encode(requestBody));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      AuthenticationResponseModel authenticationResponseModel =
          AuthenticationResponseModel.fromJson(responseData);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Login Successfully',
        'data': authenticationResponseModel,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': 'Login Failed',
        'data': json.decode(response.body)
      };
    }
    return result;
  }

  void changePasswordVisibility(){
    if (_passwordVisibility == PasswordVisibility.PasswordHidden) {
      _passwordVisibility = PasswordVisibility.PasswordVisible;
      notifyListeners();
    }  else {
      _passwordVisibility = PasswordVisibility.PasswordHidden;
      notifyListeners();
    }
  }
}
