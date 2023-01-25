import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/features/auth/login/models/login_model.dart';

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

}
