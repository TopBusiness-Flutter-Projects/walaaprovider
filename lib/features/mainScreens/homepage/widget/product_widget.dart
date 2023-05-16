import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';
import 'package:walaaprovider/features/addproduct/presentation/cubit/add_product_cubit.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.model, required this.index})
      : super(key: key);
  final ProductModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          shape: BoxShape.rectangle,
          color: AppColors.color2),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    shape: BoxShape.rectangle,
                    color: Colors.white),
                child: Center(
                    child: CachedNetworkImage(
                  imageUrl: model.image!,
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      backgroundImage: imageProvider,
                    );
                  },
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                )),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      shape: BoxShape.rectangle,
                      color: AppColors.color2),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        model.name!,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.edit_calendar_outlined,
                              color: AppColors.onBoardingColor,
                            ),
                            onTap: () {
                              // context.read<AddProductCubit>().addProductModel.image = model.image!;
                              // context.read<AddProductCubit>().addProductModel.name_ar = model.name_ar!;
                              // context.read<AddProductCubit>().addProductModel.name_en = model.name_en!;
                              // context.read<AddProductCubit>().addProductModel.cat_id = model.category_id!;
                              // context.read<AddProductCubit>().addProductModel.price = model.price.toString();
                              // context.read<AddProductCubit>().controllerName_ar.text = model.name_ar!;
                              // context.read<AddProductCubit>().controllerprice.text = model.price.toString();
                              // context.read<AddProductCubit>().controllerName_en.text = model.name_en!;
                              // context.read<AddProductCubit>().controllerpriceafter.text = model.price_after_discount==0?'':model.price_after_discount!.toString();
                              // context.read<AddProductCubit>().getUserData();
                               context.read<AddProductCubit>().getSingleProduct(
                                   model.id!,
                                   context,
                                   context
                                       .read<HomeCubit>()
                                       .userModel
                                       .access_token);


                             Future.delayed(Duration(seconds: 1)).then((value) => Navigator.pushNamed(
                                  context, Routes.addProductRoute,
                                  arguments: model));
                            },
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<HomeCubit>()
                                  .deleteProduct(model, index);
                            },
                            child: MySvgWidget(
                              path: ImageAssets.removeIcon,
                              color: AppColors.onBoardingColor,
                              width: 16,
                              height: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              )),
          Positioned(
              right: 0,
              bottom: 60,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.onBoardingColor),
                  child: Center(
                   child: Text(
                    model.price_after_discount==0? model.price.toString():model.price_after_discount.toString(),
                     style: TextStyle(
                       color: AppColors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 14,
                     ),
                   ),
                      ),
                ),
              ))  ,
          Positioned(
              left: 0,
              bottom: 60,
              child: Visibility(
                visible:  model.price_after_discount==0?false:true,

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.onBoardingColor),
                    child: Center(
                      child: Text(
                      model.price.toString(),

                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                         decorationColor: AppColors.error,

                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
