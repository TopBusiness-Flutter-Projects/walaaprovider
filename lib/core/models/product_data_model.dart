import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';

class ProductDataModel {
  List<ProductModel> data=[];
  late StatusResponse status;


  ProductDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new ProductModel.fromJson(v));
      });
    }
    status = StatusResponse.fromJson(json);
  }

}