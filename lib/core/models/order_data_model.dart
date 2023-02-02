import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';

class OrderDataModel {
  List<OrderModel> data=[];
  late StatusResponse status;



  OrderDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new OrderModel.fromJson(v));
      });
    }
    status = StatusResponse.fromJson(json);

  }

}

