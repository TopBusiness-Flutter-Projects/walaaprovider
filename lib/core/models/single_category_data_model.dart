import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';

class SingleCategoryDataModel {
  late CategoryModel data;
  late StatusResponse status;

  SingleCategoryDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
     data=CategoryModel.fromJson(json['data']);
    }
    status = StatusResponse.fromJson(json);
  }
}
