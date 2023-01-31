import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/category_data_model.dart';
import 'package:walaaprovider/core/models/product_data_model.dart';
import 'package:walaaprovider/core/models/settings.dart';
import 'package:walaaprovider/core/models/single_category_data_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/features/addcategorypage/model/add_category_model.dart';
import 'package:walaaprovider/features/auth/login/models/login_model.dart';
import 'package:walaaprovider/features/auth/register/models/register_model.dart';

import '../utils/end_points.dart';
import 'package:walaaprovider/injector.dart' as injector;

class ServiceApi {
  final Dio dio;

  ServiceApi(this.dio){
    if (kDebugMode) {
      dio.interceptors.add(injector.serviceLocator<LogInterceptor>());
    }
  }
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
  Future<CategoryDataModel> getCategory(String token, String lan) async {
    final response = await dio.get(
      EndPoints.categoryUrl,
      options: Options(
        headers: {
          'Authorization': token,
          'Accept-Language': lan,
        },
      ),
    );
    print('Url : ${EndPoints.categoryUrl}');
    print('Response : \n ${response.data}');
    return CategoryDataModel.fromJson(response.data);
  }
  Future<ProductDataModel> getProduct(String token, String lan,int category_id) async {
    final response = await dio.get(
      EndPoints.productUrl+"/${category_id}",

      options: Options(
        headers: {
          'Authorization': token,
          'Accept-Language': lan,
        },
      ),
    );
    print('Url : ${EndPoints.productUrl}');
    print('Response : \n ${response.data}');
    return ProductDataModel.fromJson(response.data);
  }
  Future<SettingModel> getsetting() async {
    final response = await dio.get(
      EndPoints.settingUrl,

      // options: Options(
      //   headers: {
      //     'Authorization': token,
      //     'Accept-Language': lan,
      //   },
      // ),
    );
    print('Url : ${EndPoints.productUrl}');
    print('Response : \n ${response.data}');
    return SettingModel.fromJson(response.data);
  }
  Future<StatusResponse> addCategory(AddCategoryModel addCategoryModel,String token) async {
    var fields = FormData.fromMap({});
    fields = FormData.fromMap({
      "name_ar":addCategoryModel.name_ar,
      "name_en":addCategoryModel.name_en,
      "image": await MultipartFile.fromFile(addCategoryModel.image)

    });
    Response response = await dio.post(
      EndPoints.addcategoryUrl,

      options: Options(
        headers: {
          'Authorization': token
        },
      ),
      data: fields,
    );

    print('Url : ${fields.files}');

    print('Url : ${EndPoints.loginUrl}');
    print('Url : ${addCategoryModel.image}');
    print('Response : \n ${response.data}');
    return StatusResponse.fromJson(response.data);
  }
  Future<SingleCategoryDataModel> getsingleCategory(int id) async {
    final response = await dio.get(
      EndPoints.singlecategoryUrl+"/${id}",

      // options: Options(
      //   headers: {
      //     'Authorization': token,
      //     'Accept-Language': lan,
      //   },
      // ),
    );
    print('Url : ${EndPoints.productUrl}');
    print('Response : \n ${response.data}');
    return SingleCategoryDataModel.fromJson(response.data);
  }

}
