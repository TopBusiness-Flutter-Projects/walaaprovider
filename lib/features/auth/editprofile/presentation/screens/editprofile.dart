import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/core/widgets/network_image.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/toast_message_method.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/my_svg_widget.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    EditProfileCubit editProfileCubit = context.read<EditProfileCubit>();

    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
        backgroundColor: AppColors.grey8,
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
              'edit_profile'.tr(),
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.white,
        ),
        body: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileErrorMessages) {
              toastMessage(
                editProfileCubit.message,
                context,
                color: AppColors.error,
              );
            }
            if (state is EditProfileError) {
              toastMessage(
                editProfileCubit.message,
                context,
                color: AppColors.error,
              );
            }
            if (state is OnEditProfileVaildFaild) {
              formKey.currentState!.validate();
            }
            if (state is OnEditProfileVaild) {
              formKey.currentState!.validate();
            }
          },
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
            return SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                child: ClipOval(
                                    child: editProfileCubit.imagePath.isEmpty
                                        ? ManageNetworkImage(
                                            imageUrl: editProfileCubit
                                                .editProfileModel.image,
                                            width: 140,
                                            height: 140,
                                            borderRadius: 140,
                                          )
                                        : Image.file(
                                            File(
                                              editProfileCubit.imagePath,
                                            ),
                                            width: 140.0,
                                            height: 140.0,
                                            fit: BoxFit.cover,
                                          )),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              right: MediaQuery.of(context).size.width / 2 - 70,
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                editProfileCubit.pickImage(
                                                  type: 'camera',
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.camera_alt,
                                                        size: 45,
                                                        color: AppColors.gray),
                                                    Text('camera')
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                editProfileCubit.pickImage(
                                                  type: 'photo',
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.photo,
                                                        size: 45,
                                                        color: AppColors.gray),
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
                        SizedBox(height: 40),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  cursorColor: AppColors.primary,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                 controller: editProfileCubit.controllerFirstName,
                                  onChanged: (data) {
                                    editProfileCubit
                                        .editProfileModel.first_name = data;
                                    context
                                        .read<EditProfileCubit>()
                                        .checkValidEditProfileData();
                                  },
                                  validator: (value) {
                                    return editProfileCubit.editProfileModel
                                            .error_first_name.isNotEmpty
                                        ? editProfileCubit
                                            .editProfileModel.error_first_name
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'first_name'.tr(),
                                      hintStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.color2,
                          height: 3,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  cursorColor: AppColors.primary,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: editProfileCubit.controllerLastName,

                                  onChanged: (data) {
                                    editProfileCubit
                                        .editProfileModel.last_name = data;
                                    editProfileCubit
                                        .checkValidEditProfileData();
                                  },
                                  validator: (value) {
                                    return editProfileCubit.editProfileModel
                                            .error_last_name.isNotEmpty
                                        ? editProfileCubit
                                            .editProfileModel.error_last_name
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'last_name'.tr(),
                                      hintStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.color2,
                          height: 3,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: InternationalPhoneNumberInput(
                                  locale: lang,

                                  errorMessage: editProfileCubit
                                      .editProfileModel.error_phone,
                                  isEnabled: false,

                                  onInputChanged: (PhoneNumber number) {
                                    print("sssss${number.phoneNumber}");
                                    editProfileCubit.editProfileModel.phone =
                                        number.phoneNumber!
                                            .replaceAll(number.dialCode!, "")!;
                                    editProfileCubit.editProfileModel.code =
                                        number.isoCode!;
                                    editProfileCubit.editProfileModel
                                        .phone_code = number.dialCode!;
                                    editProfileCubit
                                        .checkValidEditProfileData();
                                  },

                                  onInputValidated: (bool value) {
                                    print("ssssffffs${value}");
                                    if(!value&&editProfileCubit.editProfileModel.vaild){
                                      editProfileCubit
                                          .checkValidEditProfileData();
                                    }
                                  },
                                  autoFocusSearch: true,

                                  initialValue: PhoneNumber(

                                      isoCode: editProfileCubit
                                              .editProfileModel.code.isNotEmpty
                                          ? editProfileCubit
                                              .editProfileModel.code
                                          : "SA"

                                  ,
                                  ),
                                  validator: (p0) {
                                    return editProfileCubit.editProfileModel.vaild?null:editProfileCubit.editProfileModel.error_phone;
                                  },
                                  textFieldController: editProfileCubit.controllerPhone,
                                  selectorConfig: SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                    showFlags: false,
                                    setSelectorButtonAsPrefixIcon: true,
                                    useEmoji: true,
                                    trailingSpace: false,
                                    leadingPadding: 0,
                                  ),

                                  ignoreBlank: false,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  selectorTextStyle:
                                      TextStyle(color: Colors.black),
                                  // initialValue: number,
                                  // textFieldController: controller,
                                  hintText: 'phone'.tr(),
                                  formatInput: true,

                                  spaceBetweenSelectorAndTextField: 2,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  // inputBorder: OutlineInputBorder(),
                                  inputBorder: InputBorder.none,
                                  onSaved: (PhoneNumber number) {
                                    print('On Saved: $number');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.color2,
                          height: 3,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  cursorColor: AppColors.primary,
                                  controller: editProfileCubit.controllerlocation,

                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (data) {
                                    editProfileCubit.editProfileModel.location =
                                        data;
                                    editProfileCubit
                                        .checkValidEditProfileData();
                                  },
                                  validator: (value) {
                                    return editProfileCubit.editProfileModel
                                            .error_location.isNotEmpty
                                        ? editProfileCubit
                                            .editProfileModel.error_location
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'location'.tr(),
                                      hintStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.color2,
                          height: 3,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  autofocus: false,
                                  cursorColor: AppColors.primary,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (data) {
                                    editProfileCubit.editProfileModel.password =
                                        data;
                                    editProfileCubit
                                        .checkValidEditProfileData();
                                  },
                                  validator: (value) {
                                    return editProfileCubit.editProfileModel
                                            .error_password.isNotEmpty
                                        ? editProfileCubit
                                            .editProfileModel.error_password
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'password'.tr(),
                                      hintStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.color2,
                          height: 3,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  autofocus: false,
                                  cursorColor: AppColors.primary,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (data) {
                                    editProfileCubit.editProfileModel
                                        .confirm_password = data;
                                    editProfileCubit
                                        .checkValidEditProfileData();
                                  },
                                  validator: (value) {
                                    return editProfileCubit.editProfileModel
                                            .error_confirm_password.isNotEmpty
                                        ? editProfileCubit.editProfileModel
                                            .error_confirm_password
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'confirm_password'.tr(),
                                      hintStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.color2,
                          height: 3,
                          thickness: 3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textcolor: AppColors.color1,
                          text: 'edit_profile'.tr(),
                          color: editProfileCubit.isEditProfileValid
                              ? AppColors.buttonBackground
                              : AppColors.gray,
                          onClick: () {

                            print("dddd${formKey.currentState!.validate()}");
                            if (formKey.currentState!.validate()) {
                              editProfileCubit.userEditProfile(context);
                              print('all is well !!');
                            }
                          },
                          paddingHorizontal: 60,
                          borderRadius: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
