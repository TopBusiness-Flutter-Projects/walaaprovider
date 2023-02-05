import 'package:walaaprovider/core/models/order_detials_model.dart';
import 'package:walaaprovider/core/models/user.dart';

class OrderModel {
  late int id;
  late dynamic totalPrice;
  late String note;
  late User userData;
  late List<OrderDetailsModel> orderDetails;
  late String dataTime;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['total_price'];
    note = json['note']??'';
    userData = User.fromJson(json['user_data']);
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetailsModel.fromJson(v));
      });
    }
    dataTime = json['data_time'];
  }
}
