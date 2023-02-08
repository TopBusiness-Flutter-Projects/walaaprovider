import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';
import 'package:walaaprovider/features/auth/newpassword/model/new_password_model.dart';


import 'cubit/new_password_cubit.dart';
import 'cubit/new_password_state.dart';

class NewPassword extends StatefulWidget {
  final NewPasswordModel newPasswordModel;

  NewPassword({Key? key, required this.newPasswordModel}) : super(key: key);

  @override
  State<NewPassword> createState() =>
      _NewPasswordState(newPasswordModel: newPasswordModel);
}

class _NewPasswordState extends State<NewPassword> {
  bool isHidden = false;
  NewPasswordModel newPasswordModel;

  _NewPasswordState({required this.newPasswordModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: body(context, newPasswordModel));
  }
}

Widget body(BuildContext context, NewPasswordModel newPasswordModel) {
  NewPasswordCubit cubit = BlocProvider.of<NewPasswordCubit>(context);
  cubit.model = newPasswordModel;
  return BlocListener<NewPasswordCubit, NewPasswordState>(
      listener: (context, state) {
    print("Status=>${state}");
    if (state is OnNewPasswordSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginRoute,
        ModalRoute.withName(Routes.newpassRoute),
      );
    }
  }, child: LayoutBuilder(builder: (context, constraints) {
    return BlocBuilder<NewPasswordCubit, NewPasswordState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                      child: Image.asset(
                        ImageAssets.newpassordImage,

                  )),
                ],
              ),

              Container(

                child: Row(
                  children: [

                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,

                        autofocus: false,
                        cursorColor: AppColors.primary,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          context
                              .read<NewPasswordCubit>()
                              .model
                              .password = data;
                          context
                              .read<NewPasswordCubit>()
                              .checkData();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'password'.tr(),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MySvgWidget(
                                path: ImageAssets.lockIcon,
                                color: AppColors.primary,
                                width: 16,
                                height: 16,
                              ),
                            ),
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

                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: AppColors.primary,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          context
                              .read<NewPasswordCubit>()
                              .model
                              .confirm_password = data;
                          context
                              .read<NewPasswordCubit>()
                              .checkData();
                        },
                        decoration: InputDecoration(

                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MySvgWidget(
                                path: ImageAssets.lockIcon,
                                color: AppColors.primary,
                                width: 10,
                                height: 10,
                              ),
                            ),
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
              const SizedBox(height: 48),
              BlocBuilder<NewPasswordCubit, NewPasswordState>(
                  builder: (context, state) {
                bool isValid = cubit.isDataValid;
                if (state is OnNewPasswordSuccess) {
                  isValid = false;
                } else if (state is UserDataValidation) {
                  isValid = state.valid;
                } else if (state is OnError) {}
                return MaterialButton(
                  onPressed: () {
                    cubit.newPassword(context);
                  },
                  padding: EdgeInsets.all(10),
                  height: 56.0,


                  color: isValid ? AppColors.primary : AppColors.grey4,
                  disabledColor: AppColors.grey4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    'done'.tr(),
                    style:
                         TextStyle(fontSize: 16.0, color: AppColors.white),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }));
}
