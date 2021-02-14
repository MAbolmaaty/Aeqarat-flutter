import 'dart:convert';
import 'dart:io';

import 'package:aeqarat/src/models/authentication_response_model.dart';
import 'package:aeqarat/src/utils/networking/app_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
  NotRegistered,
  Registered,
  Registering,
}

enum PasswordVisibility {
  PasswordVisible,
  PasswordHidden,
}

class AuthenticationApi with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredStatus = Status.NotRegistered;
  PasswordVisibility _passwordVisibility = PasswordVisibility.PasswordHidden;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredStatus => _registeredStatus;

  PasswordVisibility get passwordVisibility => _passwordVisibility;

  Future<Map<String, dynamic>> register(String username, String email,
      String password, String passwordConfirmation, String phoneNumber, File profilePicture) async {
    var result;

    final Map<String, String> headers = {'Content-type': "multipart/form-data"};

    final Map<String, String> requestBody = {
      "data": json.encode({
        'username': username,
        'email': email,
        'password': password,
        'passwordConfirmation': passwordConfirmation,
        'phoneNumber': phoneNumber,
      }).toString()
    };

    _registeredStatus = Status.Registering;
    notifyListeners();

    var request;
    try {
      request = MultipartRequest('POST', Uri.parse(AppUrl.register_url))
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
    } on Exception catch (e) {
      e.toString();
    }

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      AuthenticationResponseModel authenticationResponseModel =
          AuthenticationResponseModel.fromJson(responseData);

      _registeredStatus = Status.Registered;
      notifyListeners();

      result = {
        'status' : true,
        'message' : 'Successfully Registered',
        'data' : authenticationResponseModel
      };
    } else {
      _registeredStatus = Status.NotRegistered;
      notifyListeners();
      result = {
        'status': false,
        'message': 'Register Failed',
        'data': responseData
      };
    }
    return result;
  }

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

  void changePasswordVisibility() {
    if (_passwordVisibility == PasswordVisibility.PasswordHidden) {
      _passwordVisibility = PasswordVisibility.PasswordVisible;
      notifyListeners();
    } else {
      _passwordVisibility = PasswordVisibility.PasswordHidden;
      notifyListeners();
    }
  }
}
