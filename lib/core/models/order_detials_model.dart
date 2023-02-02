import 'package:walaaprovider/core/models/product_model.dart';

class OrderDetailsModel{
 late int id;
 late int qty;
 late ProductModel product;


  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    product = ProductModel.fromJson(json['product']);  }

}
