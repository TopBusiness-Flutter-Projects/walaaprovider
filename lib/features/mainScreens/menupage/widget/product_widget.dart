import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';

import '../../../../core/preferences/preferences.dart';
import '../model/cart_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.model}) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        shape: BoxShape.rectangle,
        color: AppColors.color2,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: model.image!,
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(backgroundImage: imageProvider);
                  },
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    shape: BoxShape.rectangle,
                    color: AppColors.color2),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          Preferences pref = Preferences.instance;
                          CartModel cartModel = await pref.getCart();
                          // pref.clearCartData();
                          print('============================================');
                          print(CartModel.toJson(cartModel));
                          print('============================================');
                        },
                        child: Text(
                          model.name!,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          print(model.toJson());
                          print('============================');

                           Preferences.instance.addItemToCart(model);
                        },
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MySvgWidget(
                                path: ImageAssets.cartIcon,
                                width: 16,
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 35,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.onBoardingColor,
                ),
                child: Center(
                  child: Text(
                    model.price.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
