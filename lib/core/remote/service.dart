import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/features/auth/login/models/login_model.dart';
import 'package:walaaprovider/features/auth/register/models/register_model.dart';

import '../utils/end_points.dart';
import 'handle_exeption.dart';

class ServiceApi {
  final Dio dio;

  ServiceApi(this.dio);
  Future<UserDataModel> userLogin(LoginModel model) async {
    Response response = await dio.post(
      EndPoints.loginUrl,
      data: {
        "phone": model.phone,
        "phone_code": model.phone_code,
        "password": model.password,
      },
    );
    print('Url : ${EndPoints.loginUrl}');
    print('Response : \n ${response.data}');
    return UserDataModel.fromJson(response.data);
  }

  Future<UserDataModel> userRegister(RegisterModel registerModel) async {

    Response response = await dio.post(
      EndPoints.registerUrl,
      data: {

        "name":registerModel.first_name+registerModel.last_name,
        "role_id":registerModel.role_id,
        "location":registerModel.location,
        "phone": registerModel.phone,
        "phone_code": registerModel.phone_code,
        "password": registerModel.password, "phone": registerModel.phone,
        "phone_code": registerModel.phone_code,
        "password": registerModel.password,
      },
    );
    print('Url : ${EndPoints.loginUrl}');
    print('Response : \n ${response.data}');
    return UserDataModel.fromJson(response.data);
  }

}
