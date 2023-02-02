import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';

import '../../../../core/preferences/preferences.dart';
import '../../../../core/widgets/outline_button_widget.dart';
import '../cubit/menu_cubit.dart';
import '../model/cart_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.model}) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
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
                          openDialog(model, context);
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

  openDialog(ProductModel model, BuildContext context) {
    MenuCubit cubit = context.read<MenuCubit>();
    cubit.itemPrice = model.price!;
    cubit.itemCount = 1;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        titlePadding: EdgeInsets.zero,
        content: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CachedNetworkImage(
                            imageUrl: model.image!,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                  backgroundImage: imageProvider);
                            },
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                model.name!,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${cubit.itemPrice} SAR',
                                style: TextStyle(color: AppColors.primary),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: null,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => cubit.changeItemCount(
                                              '+', model.price!),
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          '${cubit.itemCount}',
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                        SizedBox(width: 16),
                                        InkWell(
                                          onTap: () => cubit.changeItemCount(
                                            '-',
                                            model.price!,
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Spacer(),
                        OutLineButtonWidget(
                          text: 'confirm',
                          borderColor: AppColors.success,
                          onclick: () {
                            Navigator.pop(context);
                            Preferences.instance.addItemToCart(
                              model,
                              cubit.itemCount,
                            );
                          },
                        ),
                        Spacer(),
                        OutLineButtonWidget(
                          text: 'cancel',
                          borderColor: AppColors.error,
                          onclick: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
