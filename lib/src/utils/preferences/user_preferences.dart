import 'package:aeqarat/src/models/profile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(ProfileResponseModel profileResponseModel) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (profileResponseModel.profilePicture != null) {
      sharedPreferences.setString(
          'profile_picture', profileResponseModel.profilePicture.url);
    }
    sharedPreferences.setString('username', profileResponseModel.username);
    sharedPreferences.setString('email', profileResponseModel.email);
    sharedPreferences.setString(
        'phone_number', profileResponseModel.phoneNumber);

    return true;
  }

  Future<ProfileResponseModel> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String profilePicture;
    if (sharedPreferences.getString('profile_picture') != null) {
      profilePicture = sharedPreferences.getString('profile_picture');
    }
    String username = sharedPreferences.getString('username');
    String email = sharedPreferences.getString('email');
    String phoneNumber = sharedPreferences.getString('phone_number');

    return ProfileResponseModel(
        profilePicture: ProfilePicture(url: profilePicture),
        username: username,
        email: email,
        phoneNumber: phoneNumber);
  }

  Future<bool> removeUser() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('profile_picture') != null) {
      sharedPreferences.remove('profile_picture');
    }
    sharedPreferences.remove('api_token');
    sharedPreferences.remove('username');
    sharedPreferences.remove('email');
    return sharedPreferences.remove('phone_number');
  }
}
