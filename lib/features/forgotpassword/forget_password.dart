import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';

import 'cubit/forgot_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    ForgotPasswordCubit cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return Scaffold(
        backgroundColor: AppColors.grey8,
        resizeToAvoidBottomInset: false,
        body:
  BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          print("Status=>${state}");
          if (state is OnForgotPasswordSuccess) {
            print("ddddd");
            print(state.user.user.phone);
context.read<VerficationCubit>().model.token=state.user.access_token;
context.read<VerficationCubit>().model.phone=state.user.user.phone;
            context.read<VerficationCubit>().phoneController.text=state.user.user.phone_code+state.user.user.phone;
            context.read<VerficationCubit>().sendSmsCode();
            Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.verficationRoute,
                ModalRoute.withName(Routes.forgotpassRoute),
                arguments: state.user.user.phone_code+state.user.user.phone
            );
            // Navigator.pushReplacementNamed(
            //     context, AppConstant.checkcodePasswordRoute,arguments: cubit.email);
          }
        }, child: LayoutBuilder(builder: (context, constraints) {
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Center(
                  child: Image.asset(
                    ImageAssets.forgotpassordImage,
                  ),
                ),
              ),
              SizedBox(
                height: 90,
              ),
              Container(
                child: Row(
                  children: [
                    MySvgWidget(
                      path: ImageAssets.phoneIcon,
                      color: AppColors.primary,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        cursorColor: AppColors.primary,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          context.read<ForgotPasswordCubit>().phone = data;
                          cubit.checkValidForgotPasswordData();
                        },
                        validator: (value) {
                          return context.read<ForgotPasswordCubit>().phone.isEmpty
                              ? "field_requires".tr()
                              : null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'phone'.tr(),
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
              const SizedBox(height: 60),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    bool isValid = cubit.isForgotPasswordValid;
                    if (state is OnForgotPasswordVaildFaild) {
                      isValid = false;
                    } else if (state is OnForgotPasswordVaild) {
                      isValid = true;
                    } else if (state is OnError) {}
                    return MaterialButton(
                      onPressed: () {
                        cubit.forgotPassword(context);
                      },
                      padding: EdgeInsets.all(10),
                      height: 56.0,
                      color: isValid ? AppColors.primary : AppColors.grey4,
                      disabledColor: AppColors.grey4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        'send'.tr(),
                        style: TextStyle(fontSize: 16.0, color: AppColors.white),
                      ),
                    );
                  })
            ],
          ),
        ),
      );
    })));
  }
}


