

import 'package:walaaprovider/core/models/user.dart';

class UserModel {
  late User user;
  late String access_token;
  late String firebase_token = '';

  UserModel() {
    user = User();
    user.isLoggedIn = false;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);

    access_token =
        json['access_token'] != null ? json['access_token'] as String : '';

  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'user': User.toJson(user.user),

      'access_token': user.access_token,
      'firebase_token': user.firebase_token,

  };
  }
}



