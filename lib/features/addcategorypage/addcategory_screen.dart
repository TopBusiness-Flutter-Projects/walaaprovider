import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/core/widgets/custom_button.dart';
import 'package:walaaprovider/core/widgets/network_image.dart';
import 'package:walaaprovider/features/addcategorypage/addcategory_screen.dart';
import 'package:walaaprovider/features/addcategorypage/cubit/addcategory_cubit.dart';
import 'package:walaaprovider/features/addcategorypage/model/add_category_model.dart';

class AddCategory extends StatefulWidget {
  late CategoryModel categoryModel;

  AddCategory({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print("sssss${widget.categoryModel.id}");
    context.read<AddcategoryCubit>().getUserData();
    if (widget.categoryModel.id == 0) {
      context.read<AddcategoryCubit>().checkValidData();
    }
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => {
                context.read<AddcategoryCubit>().controllerName_en.text = "",
                context.read<AddcategoryCubit>().controllerName_ar.text = '',
                context.read<AddcategoryCubit>().imagePath = "",
                widget.categoryModel = CategoryModel.name(0, '', ''),
                context.read<AddcategoryCubit>().addCategoryModel =
                    AddCategoryModel(),
                Navigator.pop(context)
              },
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
              widget.categoryModel.id == 0
                  ? 'addcategory'.tr()
                  : "editcategory".tr(),
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.color1,
        ),
        body: BlocListener<AddcategoryCubit, AddcategoryState>(
            listener: (context, state) {
          if (state is OnUserDataVaild) {
            print("Dldlldl${widget.categoryModel.id}");
            if (widget.categoryModel.id != 0) {
              context.read<AddcategoryCubit>().getSingleCategory(
                  widget.categoryModel.id,
                  context,
                  context.read<AddcategoryCubit>().userModel!.access_token);
            }
          }
          if (state is OnAddcategoryError) {
            toastMessage(
              context.read<AddcategoryCubit>().message,
              context,
              color: AppColors.error,
            );
          }

          if (state is OnAddcategoryVaildFaild) {
            formKey.currentState!.validate();
          }
          if (state is OnAddcategoryVaild) {
            formKey.currentState!.validate();
          }
        }, child: BlocBuilder<AddcategoryCubit, AddcategoryState>(
                builder: (context, state) {
          AddcategoryCubit cubit = context.read<AddcategoryCubit>();
          if (state is OncategoryLoaded) {
            CategoryModel categoryModel = state.data;
            print("object${categoryModel.name_en}");
            cubit.addCategoryModel.image = categoryModel.image;
            cubit.addCategoryModel.name_ar = categoryModel.name_ar;
            cubit.addCategoryModel.name_en = categoryModel.name_en;
            cubit.controllerName_ar.text = categoryModel.name_ar;
            cubit.controllerName_en.text = categoryModel.name_en;
            cubit.checkValidData();
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
                                    child: widget.categoryModel.id != 0
                                        ? cubit.imagePath.isEmpty
                                            ? cubit.addCategoryModel.image
                                                    .isNotEmpty
                                                ? ManageNetworkImage(
                                                    imageUrl: cubit
                                                        .addCategoryModel.image,
                                                    width: 140,
                                                    height: 140,
                                                    borderRadius: 140,
                                                  )
                                                : Image.asset(
                                                    ImageAssets.mugImage)
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
                                                      .read<AddcategoryCubit>()
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
                                                      .read<AddcategoryCubit>()
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
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              maxLines: 1,
                              controller: cubit.controllerName_ar,
                              cursorColor: AppColors.primary,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onChanged: (data) {
                                cubit.addCategoryModel.name_ar = data;
                                cubit.checkValidData();
                              },
                              validator: (value) {
                                return cubit.addCategoryModel.error_name_ar
                                        .isNotEmpty
                                    ? cubit.addCategoryModel.error_name_en
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
                                cubit.addCategoryModel.name_en = data;
                                cubit.checkValidData();
                              },
                              validator: (value) {
                                return cubit.addCategoryModel.error_name_en
                                        .isNotEmpty
                                    ? cubit.addCategoryModel.error_name_en
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
                          SizedBox(
                            height: 100,
                          ),
                          CustomButton(
                            textcolor: AppColors.color1,
                            text: widget.categoryModel.id == 0
                                ? 'addcategory'.tr()
                                : "editcategory".tr(),
                            color: context.read<AddcategoryCubit>().isValid
                                ? AppColors.buttonBackground
                                : AppColors.gray,
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                if (widget.categoryModel.id == 0) {
                                  cubit.addcategory(context);
                                } else {
                                  cubit.editcategory(
                                      context, widget.categoryModel.id);
                                }
                                // context
                                //     .read<AddcategoryCubit>()
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
