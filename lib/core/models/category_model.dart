class CategoryModel {
  int id=0;
  String name='';
  String name_ar='';
  String name_en='';
  String image='';


  CategoryModel.name(this.id, this.name, this.image);

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??"";
    name_ar = json['name_ar']??"";
    name_en = json['name_en']??"";
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.name_ar;
    data['name_en'] = this.name_en;
    data['image'] = this.image;
    return data;
  }
}
