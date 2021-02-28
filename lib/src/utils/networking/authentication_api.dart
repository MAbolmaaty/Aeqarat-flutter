import 'dart:convert';
import 'dart:io';

import 'package:aeqarat/src/models/authentication_response_model.dart';
import 'package:aeqarat/src/models/profile_response_model.dart';
import 'package:aeqarat/src/utils/networking/app_url.dart';
import 'package:aeqarat/src/utils/preferences/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  LoggingIn,
  NotRegistered,
  Registered,
  Registering,
}

enum PasswordVisibility {
  PasswordVisible,
  PasswordHidden,
}

enum Authentication {
  Authenticated,
  LoggingOut,
  Unauthenticated,
}

enum ProfilePicture {
  Uploaded,
  NotUploaded,
}

class AuthenticationApi with ChangeNotifier {
  Status _registeredStatus = Status.NotRegistered;
  Status _loggedInStatus = Status.NotLoggedIn;
  Authentication _authenticationStatus = Authentication.Unauthenticated;
  PasswordVisibility _passwordVisibility = PasswordVisibility.PasswordHidden;
  PasswordVisibility _registerPasswordVisibility =
      PasswordVisibility.PasswordHidden;
  PasswordVisibility _registerConfirmPasswordVisibility =
      PasswordVisibility.PasswordHidden;
  ProfilePicture _profilePicture = ProfilePicture.NotUploaded;

  Status get registeredStatus => _registeredStatus;

  Status get loggedInStatus => _loggedInStatus;

  Authentication get authenticationStatus => _authenticationStatus;

  PasswordVisibility get passwordVisibility => _passwordVisibility;

  PasswordVisibility get registerPasswordVisibility =>
      _registerPasswordVisibility;

  PasswordVisibility get registerConfirmPasswordVisibility =>
      _registerConfirmPasswordVisibility;

  ProfilePicture get profilePictureStatus => _profilePicture;

  Future<Map<String, dynamic>> register(
      String username,
      String email,
      String password,
      String passwordConfirmation,
      String phoneNumber,
      File profilePicture) async {
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

    if (profilePicture == null) {
      print('there is no profile picture');
    }

    var request;
    if (profilePicture != null) {
      try {
        request = MultipartRequest('POST', Uri.parse(AppUrl.register_url))
          ..headers.addAll(headers)
          ..fields.addAll(requestBody)
          ..files.add(MultipartFile(
              'files.profilePicture',
              profilePicture.readAsBytes().asStream(),
              profilePicture.lengthSync(),
              filename: username,
              contentType: MediaType('image', 'jpeg')));
      } on Exception catch (e) {
        e.toString();
        _registeredStatus = Status.NotRegistered;
        notifyListeners();
      }
    } else {
      request = MultipartRequest('POST', Uri.parse(AppUrl.register_url))
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
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
        'status': true,
        'message': 'Successfully Registered',
        'data': authenticationResponseModel
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

    _loggedInStatus = Status.LoggingIn;
    notifyListeners();

    Map<String, String> headers = {"Content-Type": "application/json"};

    Response response;
    try {
      response = await post(AppUrl.login_url,
          headers: headers, body: json.encode(requestBody));
    } on Exception catch (e) {
      e.toString();
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
    }

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

  Future<Map<String, dynamic>> profile(String apiToken) async {
    var result;

    Response response = await get(Uri.parse(AppUrl.profile_url),
        headers: {'Authorization': 'Bearer $apiToken'});

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _authenticationStatus = Authentication.Authenticated;
      notifyListeners();
      ProfileResponseModel profileResponseModel =
          ProfileResponseModel.fromJson(responseData);

      UserPreferences().saveUser(profileResponseModel);

      result = {'status': true, 'data': profileResponseModel};
    } else {
      UserPreferences().removeUser();
      result = {'status': false, 'data': responseData};
    }

    return result;
  }

  void logout() async {
    _authenticationStatus = Authentication.LoggingOut;
    notifyListeners();
    UserPreferences().removeUser().then((value) {
      if (value) {
        _authenticationStatus = Authentication.Unauthenticated;
        notifyListeners();
      }
    });
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

  void changeRegisterPasswordVisibility() {
    if (_registerPasswordVisibility == PasswordVisibility.PasswordHidden) {
      _registerPasswordVisibility = PasswordVisibility.PasswordVisible;
      notifyListeners();
    } else {
      _registerPasswordVisibility = PasswordVisibility.PasswordHidden;
      notifyListeners();
    }
  }

  void changeRegisterConfirmPasswordVisibility() {
    if (_registerConfirmPasswordVisibility ==
        PasswordVisibility.PasswordHidden) {
      _registerConfirmPasswordVisibility = PasswordVisibility.PasswordVisible;
      notifyListeners();
    } else {
      _registerConfirmPasswordVisibility = PasswordVisibility.PasswordHidden;
      notifyListeners();
    }
  }

  void profilePictureUploaded(bool uploaded) {
    if (uploaded) {
      _profilePicture = ProfilePicture.Uploaded;
      notifyListeners();
    } else {
      _profilePicture = ProfilePicture.NotUploaded;
      notifyListeners();
    }
  }
}
