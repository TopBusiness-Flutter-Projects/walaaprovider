import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/service.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  int categorLength = 0;
  int productLength = 0;
  final ServiceApi serviceApi;
  late String lang;

  late UserModel userModel;

  int itemCount = 1;
  int itemPrice=1;

  changeItemCount(String type,int price) {
    if (type == '+') {
      itemCount++;
      itemPrice = itemPrice + price;
      print(itemPrice);
      emit(ChangeItemCount());
    } else {
      if (itemCount > 1) {
        itemCount--;
        itemPrice = itemPrice  - price;
        print(itemPrice);
        emit(ChangeItemCount());
      }
    }
  }

  MenuCubit(this.serviceApi) : super(MenuInitial()) {
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
      categoryList = response.data;
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
}
