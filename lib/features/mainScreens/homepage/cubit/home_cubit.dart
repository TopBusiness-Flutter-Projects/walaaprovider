import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  int categorLength = 0;
  int productLength = 0;
  final ServiceApi serviceApi;
  late String lang;

  late UserModel userModel;

  int category_id=0;

  HomeCubit(this.serviceApi) : super(HomeInitial()) {
    getUserData().then((value) => getcategory(value));
  }

  setlang(String lang) {
    this.lang = lang;
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  getcategory(UserModel? usermodel) async {
    categorLength = 1;
    emit(AllCategoryLoading());
    final response =
        await serviceApi.getCategory(usermodel!.access_token, lang);
    if (response.status.code == 200) {
      print(response.data);
      categorLength = response.data.length;
      categoryList = response.data!;
      emit(AllCategoryLoaded(categoryList));
      if (categoryList.length > 0) {
        getProduct(usermodel, categoryList.elementAt(0).id);
      }
    } else {
      print(response.status.message);
      emit(AllCategoryError());
    }
  }

  getProduct(UserModel? usermodel, int category_id) async {
   this.category_id=category_id;
    productLength = 1;
    emit(AllProductLoading());
    final response =
        await serviceApi.getProduct(usermodel!.access_token, lang, category_id);
    if (response.status.code == 200) {
      print(response.data);
      productLength = response.data.length;
      productList = response.data!;
      emit(AllProductLoaded(productList));
    } else {
      print(response.status.message);
      emit(AllProductError());
    }
  }

  deleteCategory(CategoryModel model, int index) async {
    try {
      StatusResponse response =
          await serviceApi.deleteCategory(userModel!.access_token, model.id);
      if (response.code == 200) {
        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
        categoryList.removeAt(index);
        categorLength = categoryList.length;

        emit(AllCategoryLoaded(categoryList));
        if (productList.length > 0) {
          if (model.id == category_id) {
            getProduct(userModel, model.id);
          }
        }
      } else {
        categoryList[index] = model;
        emit(AllCategoryLoaded(categoryList));
      }
    } catch (e) {
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }

  deleteProduct(ProductModel model, int index) async {
    try {
      StatusResponse response =
          await serviceApi.deleteProduct(userModel!.access_token, model.id!);
      if (response.code == 200) {
        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
        productList.removeAt(index);
        productLength = productList.length;
        emit(AllProductLoaded(productList));
      } else {
        productList[index] = model;
        emit(AllCategoryLoaded(categoryList));
      }
    } catch (e) {
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }
}
