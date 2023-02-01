import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/core/widgets/custom_button.dart';
import 'package:walaaprovider/core/widgets/network_image.dart';
import 'package:walaaprovider/features/addproduct/presentation/cubit/add_product_cubit.dart';
import 'package:walaaprovider/features/addproduct/presentation/widgets/dropdowncategory.dart';

class AddProduct extends StatefulWidget {
  final ProductModel productModel;

  AddProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print("sssss${widget.productModel.id}");
    String lang = EasyLocalization.of(context)!.locale.languageCode;
context.read<AddProductCubit>().setlang(lang);
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.only(right: 16, left: 16),
              icon: Icon(
                Icons.arrow_forward_outlined,
                color: AppColors.primary,
                size: 35,
              ),
            ),
          ],
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Text(
              widget.productModel.id == 0
                  ? 'addProduct'.tr()
                  : "editProduct".tr(),
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.color1,
        ),
        body: BlocListener<AddProductCubit, AddProductState>(
            listener: (context, state) {
          if (state is OnUserDataVaild) {
            print("ssss${widget.productModel.id}");
            if (widget.productModel.id!= 0) {

              context.read<AddProductCubit>().getSingleProduct(
                  widget.productModel.id!,
                  context,
                  context.read<AddProductCubit>().userModel!.access_token);
            } else {
              print("ddkdkssssssk");
              context
                .read<AddProductCubit>()
                    .getcategory(context.read<AddProductCubit>().userModel);
            }
          }
          if (state is OnAddProductError) {
            toastMessage(
              context.read<AddProductCubit>().message,
              context,
              color: AppColors.error,
            );
          }

          if (state is OnAddProductVaildFaild) {
            formKey.currentState!.validate();
          }
          if (state is OnAddProductVaild) {
            formKey.currentState!.validate();
          }
        }, child: BlocBuilder<AddProductCubit, AddProductState>(
                builder: (context, state) {
          AddProductCubit cubit = context.read<AddProductCubit>();
          if (state is OnProductLoaded) {
            ProductModel productModel = state.data;
            cubit.addProductModel.image = productModel.image!;
            cubit.addProductModel.name_ar = productModel.name_ar!;
            cubit.addProductModel.name_en = productModel.name_en!;
            cubit.addProductModel.cat_id = productModel.category_id!;
            cubit.addProductModel.price = productModel.price.toString();
            cubit.controllerName_ar.text = productModel.name_ar!;
            cubit.controllerprice.text = productModel.price.toString();
            cubit.controllerName_en.text = productModel.name_en!;
            cubit.checkValidData();
            cubit.getcategory(cubit.userModel);
          }
          return SafeArea(
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 140,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: ClipOval(
                                    child: widget.productModel.id != 0
                                        ? cubit.imagePath.isEmpty
                                            ? ManageNetworkImage(
                                                imageUrl:
                                                    cubit.addProductModel.image,
                                                width: 140,
                                                height: 140,
                                                borderRadius: 140,
                                              )
                                            : Image.file(
                                                File(
                                                  cubit.imagePath,
                                                ),
                                                width: 140.0,
                                                height: 140.0,
                                                fit: BoxFit.cover,
                                              )
                                        : cubit.imagePath.isEmpty
                                            ? Image.asset(ImageAssets.mugImage)
                                            : Image.file(
                                                File(
                                                  cubit.imagePath,
                                                ),
                                                width: 140.0,
                                                height: 140.0,
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                right:
                                    MediaQuery.of(context).size.width / 2 - 70,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text('Choose'),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        content: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          child: Row(
                                            children: [
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<AddProductCubit>()
                                                      .pickImage(
                                                        type: 'camera',
                                                      );
                                                  Navigator.of(context).pop();
                                                },
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.camera_alt,
                                                          size: 45,
                                                          color:
                                                              AppColors.gray),
                                                      Text('camera')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<AddProductCubit>()
                                                      .pickImage(
                                                        type: 'photo',
                                                      );
                                                  Navigator.of(context).pop();
                                                },
                                                child: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.photo,
                                                          size: 45,
                                                          color:
                                                              AppColors.gray),
                                                      Text('Gallery')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'))
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.color1,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Icon(
                                      Icons.linked_camera_rounded,
                                      color: AppColors.primary,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              child: DropDownCategory(
                                items: cubit.categoryList,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(
                              color: AppColors.color2,
                              height: 3,
                              thickness: 3,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              maxLines: 1,
                              controller: cubit.controllerName_ar,
                              cursorColor: AppColors.primary,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: (data) {
                                cubit.addProductModel.name_ar = data;
                                cubit.checkValidData();
                              },
                              validator: (value) {
                                return cubit.addProductModel.error_name_ar
                                        .isNotEmpty
                                    ? cubit.addProductModel.error_name_en
                                    : null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'name_ar'.tr(),
                                  hintStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(
                              color: AppColors.color2,
                              height: 3,
                              thickness: 3,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              maxLines: 1,
                              controller: cubit.controllerName_en,
                              cursorColor: AppColors.primary,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: (data) {
                                cubit.addProductModel.name_en = data;
                                cubit.checkValidData();
                              },
                              validator: (value) {
                                return cubit.addProductModel.error_name_en
                                        .isNotEmpty
                                    ? cubit.addProductModel.error_name_en
                                    : null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'name_en'.tr(),
                                  hintStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(
                              color: AppColors.color2,
                              height: 3,
                              thickness: 3,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              maxLines: 1,
                              controller: cubit.controllerprice,
                              cursorColor: AppColors.primary,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (data) {
                                cubit.addProductModel.price = data;
                                cubit.checkValidData();
                              },
                              validator: (value) {
                                return cubit
                                        .addProductModel.error_price.isNotEmpty
                                    ? cubit.addProductModel.error_price
                                    : null;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'price'.tr(),
                                  hintStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(
                              color: AppColors.color2,
                              height: 3,
                              thickness: 3,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          CustomButton(
                            textcolor: AppColors.color1,
                            text: widget.productModel.id == 0
                                ? 'addProduct'.tr()
                                : "editProduct".tr(),
                            color: context.read<AddProductCubit>().isValid
                                ? AppColors.buttonBackground
                                : AppColors.gray,
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                if (widget.productModel.id == 0) {
                                  cubit.addProduct(context);
                                } else {
                                  cubit.editProduct(
                                      context, widget.productModel.id!);
                                }
                                // context
                                //     .read<AddProductCubit>()
                                //     .userRegister(context);
                                print('all is well !!');
                              }
                            },
                            paddingHorizontal: 60,
                            borderRadius: 80,
                          ),
                        ],
                      ),
                    ),
                  )));
        })));
  }
}
