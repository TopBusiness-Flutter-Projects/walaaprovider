import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user.dart';

class UserListDataModel {
  List<User> data=[];
  late StatusResponse status;


  UserListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
    status = StatusResponse.fromJson(json);
  }
  static  Map<String, dynamic> toJson(UserListDataModel cartModel) {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (cartModel.data != null) {
      data['data'] = cartModel.data!.map((v) => User.toJson(v)).toList();
    }

    return data;
  }

}