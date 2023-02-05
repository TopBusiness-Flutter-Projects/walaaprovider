import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user.dart';
import 'package:walaaprovider/core/models/user_list_data_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/features/mainScreens/menupage/model/cart_model.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';
import 'package:walaaprovider/features/navigation_bottom/cubit/navigator_bottom_cubit.dart';

import '../../../../core/preferences/preferences.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ServiceApi serviceApi;
  List<User> userList = [];

  late UserModel userModel;

  CartCubit(this.serviceApi) : super(CartInitial()) {
    getUserData();
    getTotalPrice();
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  CartModel? cartModel;
  int itemCount = 1;
  int itemPrice = 1;
  double totalPrice = 0;

  getTotalPrice() async {
    cartModel = await Preferences.instance.getCart();
    totalPrice = cartModel!.totalPrice!;
    emit(GetTotalPrice());
  }

  changeItemCount(String type, int price) {
    if (type == '+') {
      itemCount++;
      itemPrice = itemPrice + price;
      print(itemPrice);
      emit(CartChangeItemCount());
    } else {
      if (itemCount > 1) {
        itemCount--;
        itemPrice = itemPrice - price;
        print(itemPrice);
        emit(CartChangeItemCount());
      }
    }
  }

  Future<List<Map<String, String>>> getSuggestions(String pattern) async {
    final response = await serviceApi.getClients(pattern);
    if (response.status.code == 200) {
      print(response.data);
      userList = response.data;
      return Future.value(userList
          .map((e) => {'name': e.name, 'phone': e.phone.toString()})
          .toList());

      // if (categoryList.length > 0) {
      //   getProduct(usermodel, categoryList.elementAt(0).id);
      // }
    } else {
      return Future.value(userList
          .map((e) => {'name': e.name.toString(), 'phone': e.phone.toString()})
          .toList());
      //print(response.status.message);
      //  emit(AllCategoryError());
    }
  }

  sendorder(CartModel model, BuildContext context, String lang) async {

    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      StatusResponse response =
          await serviceApi.sendOrder(model, userModel.access_token);
      if (response.code == 200) {

        toastMessage("sucess".tr(), AppColors.primary);
        Preferences.instance.clearCartData();

        context.read<OrderCubit>().setlang(lang);
        context.read<OrderCubit>().getorders(userModel);
        context.read<NavigatorBottomCubit>().changePage(1, 'order'.tr());
        Navigator.pop(context);


       // Navigator.pop(context);


        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);

        // emit(AllProductLoaded(productList));
      } else {
        toastMessage(response.message, AppColors.primary);
        Navigator.pop(context);
        // productList[index] = model;
        //emit(AllCategoryLoaded(categoryList));
      }
    } catch (e) {
      print("Dldldldl${e.toString()}");
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }
}
