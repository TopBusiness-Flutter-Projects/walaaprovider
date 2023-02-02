import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/category_data_model.dart';
import 'package:walaaprovider/core/models/order_data_model.dart';
import 'package:walaaprovider/core/models/product_data_model.dart';
import 'package:walaaprovider/core/models/settings.dart';
import 'package:walaaprovider/core/models/single_category_data_model.dart';
import 'package:walaaprovider/core/models/single_product_data_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/features/addcategorypage/model/add_category_model.dart';
import 'package:walaaprovider/features/addproduct/presentation/model/add_product_model.dart';
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
  Future<OrderDataModel> getOrders(String token, String lan) async {
    final response = await dio.get(
      EndPoints.orderUrl,
      options: Options(
        headers: {
          'Authorization': token,
          'Accept-Language': lan,
        },
      ),
    );
    print('Url : ${EndPoints.orderUrl}');
    print('Response : \n ${response.data}');
    return OrderDataModel.fromJson(response.data);
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
  Future<SingleCategoryDataModel> getsingleCategory(int id,String token) async {
    final response = await dio.get(
      EndPoints.singlecategoryUrl+"/${id}",

      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
    );
    print('Url : ${EndPoints.productUrl}');
    print('Response : \n ${response.data}');
    return SingleCategoryDataModel.fromJson(response.data);
  }
  Future<StatusResponse> editcategory(AddCategoryModel addCategoryModel,String token,int cate_id) async {
    var fields = FormData.fromMap({});
    if(addCategoryModel.image.contains("http")){
      fields = FormData.fromMap({
        "name_ar":addCategoryModel.name_ar,
        "name_en":addCategoryModel.name_en,

      });
    }else{
    fields = FormData.fromMap({
      "name_ar":addCategoryModel.name_ar,
      "name_en":addCategoryModel.name_en,
      "image": await MultipartFile.fromFile(addCategoryModel.image)

    });}
    Response response = await dio.post(
      EndPoints.editcategoryUrl+"/${cate_id}",

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
  Future<StatusResponse> addProduct(AddProductModel addProductModel,String token) async {
    var fields = FormData.fromMap({});
    fields = FormData.fromMap({
      "name_ar":addProductModel.name_ar,
      "name_en":addProductModel.name_en,
      "price":addProductModel.price,
      "category_id":addProductModel.cat_id,
      "image": await MultipartFile.fromFile(addProductModel.image)

    });
    Response response = await dio.post(
      EndPoints.addproductUrl,

      options: Options(
        headers: {
          'Authorization': token
        },
      ),
      data: fields,
    );

    print('Url : ${fields.files}');

    print('Url : ${EndPoints.loginUrl}');
    print('Url : ${addProductModel.image}');
    print('Response : \n ${response.data}');
    return StatusResponse.fromJson(response.data);
  }
  Future<SingleProductDataModel> getsingleProduct(int id,String token) async {
    final response = await dio.get(
      EndPoints.singleproductUrl+"/${id}",

      options: Options(
        headers: {
          'Authorization': token,
        },
      ),
    );
    print('Url : ${EndPoints.productUrl}');
    print('Response : \n ${response.data}');
    return SingleProductDataModel.fromJson(response.data);
  }
  Future<StatusResponse> editProduct(AddProductModel addProductModel,String token,int product_id) async {
    var fields = FormData.fromMap({});
    if(addProductModel.image.contains("http")){
      fields = FormData.fromMap({
        "name_ar":addProductModel.name_ar,
        "name_en":addProductModel.name_en,
        "price":addProductModel.price,
        "category_id":addProductModel.cat_id
      });
    }else{

      fields = FormData.fromMap({
      "name_ar":addProductModel.name_ar,
      "name_en":addProductModel.name_en,
      "price":addProductModel.price,
      "category_id":addProductModel.cat_id,
      "image": await MultipartFile.fromFile(addProductModel.image)



      });}
    Response response = await dio.post(
      EndPoints.editproductUrl+"/${product_id}",

      options: Options(
        headers: {
          'Authorization': token
        },
      ),
      data: fields,
    );

    print('Url : ${fields.files}');

    print('Url : ${EndPoints.loginUrl}');
    print('Url : ${addProductModel.image}');
    print('Response : \n ${response.data}');
    return StatusResponse.fromJson(response.data);
  }
  Future<StatusResponse> deleteCategory(String user_token, int cat_id) async {
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response = await dio.post(EndPoints.deletecategoryUrl+"/${cat_id}");
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }
  Future<StatusResponse> deleteProduct(String user_token, int product_id) async {
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response = await dio.post(EndPoints.deleteproductUrl+"/${product_id}");
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }
  Future<StatusResponse> confirmOrder(String user_token, int order_id,String user_id) async {
    try {
     var fields = FormData.fromMap({

        "user_id":user_id,
        "order_id":order_id

      });
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response = await dio.post(EndPoints.confirmOrderUrl,data: fields);
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

}
