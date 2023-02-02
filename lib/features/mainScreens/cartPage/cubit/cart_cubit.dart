import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/features/mainScreens/menupage/model/cart_model.dart';

import '../../../../core/preferences/preferences.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    getTotalPrice();
  }

  CartModel? cartModel;
  int itemCount = 1;
  int itemPrice = 1;
  int totalPrice = 0;

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
}
