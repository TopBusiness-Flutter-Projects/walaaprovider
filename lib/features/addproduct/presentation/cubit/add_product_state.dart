part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}
class AddProductPickImageSuccess extends AddProductState {}
class OnAddProductVaild extends AddProductState {
}
class OnUserDataVaild extends AddProductState {
}
class OnAddProductVaildFaild extends AddProductState {

}
class OnAddProductError extends AddProductState {
}
class OnProductLoaded extends AddProductState {
  final ProductModel data;
  OnProductLoaded(this.data);
}
class OnProductError extends AddProductState {
}
class AllCategoryError extends AddProductState {}
class AllCategoryLoaded extends AddProductState {
  final List<CategoryModel> categoryList;

  AllCategoryLoaded(this.categoryList);

}
