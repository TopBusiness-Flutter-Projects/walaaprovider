import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/widgets/brown_line_widget.dart';
import 'package:walaaprovider/core/widgets/show_loading_indicator.dart';
import 'package:walaaprovider/features/mainScreens/cartPage/cubit/cart_cubit.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/outline_button_widget.dart';
import '../../menupage/cubit/menu_cubit.dart';
import '../../menupage/model/cart_model.dart';
import '../widgets/cart_model_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartModel? cartModel;

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getTotalPrice();
    getAllProductInCart(context);
  }

  getAllProductInCart(context) async {
    cartModel = await Preferences.instance.getCart();
    Future.delayed(Duration(milliseconds: 1000), () {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getTotalPrice();
    return Scaffold(
      body: cartModel == null
          ? ShowLoadingIndicator()
          : RefreshIndicator(
              onRefresh: () async {
                getAllProductInCart(context);
              },
              child: ListView(
                children: [
                  Column(
                    children: [
                      ...List.generate(
                        cartModel!.productModel!.length,
                        (index) {
                          return Stack(
                            children: [
                              CartModelWidget(
                                model: cartModel!.productModel![index],
                              ),
                              Positioned(
                                top: 10,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    Preferences.instance.deleteProduct(
                                        cartModel!.productModel![index]);
                                    Future.delayed(Duration(milliseconds: 250),
                                        () {
                                      getAllProductInCart(context);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return cartModel!.productModel!.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('total_price'.tr()),
                                    SizedBox(width: 22),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      width: 90,
                                      height: 45,
                                      child: Center(
                                        child: Text(
                                          '${context.read<CartCubit>().totalPrice}',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox();
                        },
                      ),
                      SizedBox(height: 20),
                      cartModel!.productModel!.isNotEmpty
                          ? Row(
                              children: [
                                Spacer(),
                                OutLineButtonWidget(
                                  text: 'confirm',
                                  borderColor: AppColors.success,
                                  onclick: () {
                                    openDialog(context);
                                  },
                                ),
                                Spacer(),
                                OutLineButtonWidget(
                                  text: 'cancel',
                                  borderColor: AppColors.error,
                                  onclick: () {
                                    Preferences.instance.clearCartData();
                                    Future.delayed(Duration(milliseconds: 250),
                                        () {
                                      getAllProductInCart(context);
                                    });
                                  },
                                ),
                                Spacer(),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
    );
  }

  openDialog(BuildContext context) {
    String date =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour > 12 ? '0${DateTime.now().hour - 12}' : DateTime.now().hour}:${DateTime.now().minute}';
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: null,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('order'.tr()),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLines: 1,
                      cursorColor: AppColors.primary,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (data) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'field_required'.tr();
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'first_name'.tr(),
                          hintStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    BrownLineWidget(),
                    SizedBox(height: 8),
                    TextFormField(
                      maxLines: 1,
                      cursorColor: AppColors.primary,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onChanged: (data) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'field_required'.tr();
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'phone'.tr(),
                          hintStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    BrownLineWidget(),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('total_price'.tr()),
                        SizedBox(width: 22),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8)),
                          width: 90,
                          height: 45,
                          child: Center(
                            child: Text(
                              '${context.read<CartCubit>().totalPrice}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('date'.tr()),
                        SizedBox(width: 22),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    OutLineButtonWidget(
                      text: 'confirm',
                      borderColor: AppColors.success,
                      onclick: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
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
