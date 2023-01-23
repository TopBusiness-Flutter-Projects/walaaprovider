import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/end_points.dart';
import 'handle_exeption.dart';

class ServiceApi {
  final Dio dio;

  ServiceApi(this.dio);
  // Future<LoginModel> userLogin(String email, String password) async {
  //   Response response = await dio.post(
  //     EndPoints.loginUrl,
  //     data: {
  //       "email": email,
  //       "password": password,
  //     },
  //   );
  //   print('Url : ${EndPoints.loginUrl}');
  //   print('Response : \n ${response.data}');
  //   return LoginModel.fromJson(response.data);
  // }

}
