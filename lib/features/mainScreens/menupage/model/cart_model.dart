class CartModel {
  String phone='';
  int totalPrice=0;
  String note='';
  List<OrderDetails> orderDetails=[];


  CartModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    totalPrice = json['total_price'];
    note = json['note'];
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['total_price'] = this.totalPrice;
    data['note'] = this.note;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int productId=0;
  int qty=0;


  OrderDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    return data;
  }
}