class ProductModel {
  int? id;
  String? name;
  int? price;
  String? image;
  int quantity =1 ;


  ProductModel({this.id, this.name, this.price, this.image, this.quantity = 1});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    quantity = json['quantity']??1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ProductModel = new Map<String, dynamic>();
    ProductModel['id'] = this.id;
    ProductModel['name'] = this.name;
    ProductModel['price'] = this.price;
    ProductModel['image'] = this.image;
    ProductModel['quantity'] = this.quantity;
    return ProductModel;
  }
}