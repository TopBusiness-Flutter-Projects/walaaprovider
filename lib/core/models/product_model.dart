class ProductModel {
  int id=0;
  String name='';
  int price=0;
  String image='';


  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ProductModel = new Map<String, dynamic>();
    ProductModel['id'] = this.id;
    ProductModel['name'] = this.name;
    ProductModel['price'] = this.price;
    ProductModel['image'] = this.image;
    return ProductModel;
  }
}