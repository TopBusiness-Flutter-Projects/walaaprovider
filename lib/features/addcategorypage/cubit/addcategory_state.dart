part of 'addcategory_cubit.dart';

@immutable
abstract class AddcategoryState {}

class AddcategoryInitial extends AddcategoryState {}
class AddcategoryPickImageSuccess extends AddcategoryState {}
class OnAddcategoryVaild extends AddcategoryState {
}
class OnUserDataVaild extends AddcategoryState {
}
class OnAddcategoryVaildFaild extends AddcategoryState {

}
class OnAddcategoryError extends AddcategoryState {
}
class OncategoryLoaded extends AddcategoryState {
 final CategoryModel data;
  OncategoryLoaded(this.data);
}
class OncategoryError extends AddcategoryState {
}


