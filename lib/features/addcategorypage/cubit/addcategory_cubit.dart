import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'addcategory_state.dart';

class AddcategoryCubit extends Cubit<AddcategoryState> {
  AddcategoryCubit() : super(AddcategoryInitial());
}
