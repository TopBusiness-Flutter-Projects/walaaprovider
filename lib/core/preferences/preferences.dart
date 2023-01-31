import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user.dart';
import 'package:walaaprovider/core/models/user_model.dart';

import '../../features/mainScreens/menupage/model/cart_model.dart';
import '../models/product_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;


  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('onBoarding');
    return jsonData;
  }

  Future<void> setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user', jsonEncode(UserModel.toJson(userModel)));
  }

  Future<UserModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    UserModel userModel;
    if (jsonData != null) {
      userModel = UserModel.fromJson(jsonDecode(jsonData));
      userModel.user.isLoggedIn = true;
    }else{
      userModel = UserModel();
      User user = User();
      userModel.user = user;
      userModel.user.isLoggedIn = false;

    }
    return userModel;
  }

  clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('user');
  }
  clearCartData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cart');
  }


  Future<CartModel> getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('cart');
    CartModel cartModel;
    if (jsonData != null) {
      cartModel = CartModel.fromJson(jsonDecode(jsonData));
    }else{
      cartModel = CartModel(orderDetails: [],productModel: [],phone:'',note: '',totalPrice: 0,);
    }
    return cartModel;
  }
  Future<void> setCart(CartModel cartModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cart', jsonEncode(CartModel.toJson(cartModel)));
  }

  addItemToCart(ProductModel model) async {
    CartModel cartModel = await getCart();
    bool isNew =true;
    cartModel.orderDetails!.forEach(
          (element) {
        if (element.productId == model.id) {
          int index = cartModel.orderDetails!.indexOf(element);
          cartModel.orderDetails![index].qty++;
          cartModel.productModel![index].quantity++;
          setCart(cartModel);
          isNew=false;
        }
      },
    );
    if(isNew){
      cartModel.productModel!.add(model);
      cartModel.orderDetails!.add(
        OrderDetails(
          productId: model.id!,
          qty: model.quantity,
        ),
      );
      setCart(cartModel);
    }

  }

}
