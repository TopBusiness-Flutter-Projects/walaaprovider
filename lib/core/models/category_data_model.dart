import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';

class CategoryDataModel {
  List<CategoryModel> data=[];
  late StatusResponse status;


  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];

      json['data'].forEach((v) {
        data.add(new CategoryModel.fromJson(v));
      });
    }
    status = StatusResponse.fromJson(json);
  }

}