import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/user.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/features/mainScreens/menupage/model/cart_model.dart';

import '../../features/mainScreens/cartPage/cubit/cart_cubit.dart';

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
    } else {
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
    } else {
      cartModel = CartModel(
        orderDetails: [],
        productModel: [],
        phone: '',
        note: '',
        totalPrice: 0,
      );
    }
    return cartModel;
  }

  Future<void> setCart(CartModel cartModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cart', jsonEncode(CartModel.toJson(cartModel)));
  }

  addItemToCart(ProductModel model, int qty) async {
    CartModel cartModel = await getCart();
    bool isNew = true;
    cartModel.orderDetails!.forEach(
      (element) {
        if (element.productId == model.id) {
          int index = cartModel.orderDetails!.indexOf(element);
          cartModel.orderDetails![index].qty =
              cartModel.orderDetails![index].qty + qty;
          cartModel.productModel![index].quantity =
              cartModel.productModel![index].quantity + qty;
          cartModel.totalPrice = (cartModel.totalPrice! +
              (qty * cartModel.productModel![index].price!));
          setCart(cartModel);
          isNew = false;
        }
      },
    );
    if (isNew) {
      model.quantity = qty;
      cartModel.totalPrice = (cartModel.totalPrice! + (qty * model.price!));
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

  changeProductCount(ProductModel model, int qty, double price,context) async {
    CartModel cartModel = await getCart();
    cartModel.productModel!.forEach(
      (element) {
        if (element.id == model.id) {
          int index = cartModel.productModel!.indexOf(element);
          cartModel.orderDetails![index].qty = qty;
          cartModel.productModel![index].quantity = qty;
          cartModel.totalPrice = cartModel.totalPrice! + price;
          setCart(cartModel);
        }
      },
    );
  }

  deleteProduct(ProductModel model) async {
    CartModel cartModel = await getCart();
    for (int i = 0; i <= cartModel.productModel!.length; i++) {
      if (cartModel.productModel![i].id == model.id) {
        cartModel.orderDetails!.removeAt(i);
        cartModel.productModel!.removeAt(i);
        cartModel.totalPrice =
            cartModel.totalPrice! - (model.price! * model.quantity);
        setCart(cartModel);
        break;
      }
    }
  }
}
