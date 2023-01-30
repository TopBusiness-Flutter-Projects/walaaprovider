import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user.dart';
import 'package:walaaprovider/core/models/user_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;


  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('onBoarding');
    return jsonData;
  }

  Future<void> setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user', jsonEncode(UserModel.toJson(userModel)));
  }

  Future<UserModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    UserModel userModel;
    if (jsonData != null) {
      userModel = UserModel.fromJson(jsonDecode(jsonData));
      userModel.user.isLoggedIn = true;
    }else{
      userModel = UserModel();
      User user = User();
      userModel.user = user;
      userModel.user.isLoggedIn = false;

    }

    return userModel;
  }

  clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('user');
  }
}
