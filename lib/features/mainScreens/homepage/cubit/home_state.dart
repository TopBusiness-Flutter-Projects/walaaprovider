part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class AllCategoryLoading extends HomeState {}
class AllCategoryError extends HomeState {}
class AllCategoryLoaded extends HomeState {
  final List<CategoryModel> categoryList;

  AllCategoryLoaded(this.categoryList);

}
class AllProductLoading extends HomeState {}
class AllProductError extends HomeState {}
class AllProductLoaded extends HomeState {
  final List<ProductModel> productList;

  AllProductLoaded(this.productList);

}
