import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';

class SingleProductDataModel {
  late ProductModel data;
  late StatusResponse status;

  SingleProductDataModel.fromJson(Map<String, dynamic> json) {
   print(";;l${json['data']}");
    if (json['data'] != null) {
      print(";;l${json['data']}");
     data=ProductModel.fromJson(json['data']);
    }
    status = StatusResponse.fromJson(json);
  }
}
