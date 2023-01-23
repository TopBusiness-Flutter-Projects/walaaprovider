import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/toast_message_method.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/my_svg_widget.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/Login_cubit.dart';
import '../cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey8,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorMessages) {
            toastMessage(
              context.read<LoginCubit>().message,
              context,
              color: AppColors.error,
            );
          }
          if (state is LoginError) {
            toastMessage(
              context.read<LoginCubit>().message,
              context,
              color: AppColors.error,
            );
          }
          if(state is OnLoginVaildFaild){

            formKey.currentState!.validate();
          }
          if(state is OnLoginVaild){

            formKey.currentState!.validate();
          }


        },
child: BlocBuilder<LoginCubit, LoginState>(
builder: (context, state) {
  if (state is LoginLoading) {
    return ShowLoadingIndicator();
  }

  return SafeArea(
    child: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  ImageAssets.loginImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    MySvgWidget(
                      path: ImageAssets.emailIcon,
                      color: AppColors.primary,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        cursorColor: AppColors.primary,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (data) {
                          context
                              .read<LoginCubit>()
                              .loginModel
                              .email =
                              data;
                          context
                              .read<LoginCubit>()
                              .checkValidLoginData();
                        },
                        validator: (value) {

                          return
                            context
                              .read<LoginCubit>()
                              .loginModel
                              .error_email.isNotEmpty?
                            context
                                .read<LoginCubit>()
                                .loginModel
                                .error_email:null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'email address'.tr(),
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
              SizedBox(height: 20,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    MySvgWidget(
                      path: ImageAssets.lockIcon,
                      color: AppColors.primary,
                      width: 16,
                      height: 16,
                    ),
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
                          context
                              .read<LoginCubit>()
                              .loginModel
                              .password =
                              data;
                          context
                              .read<LoginCubit>()
                              .checkValidLoginData();
                        },
                        validator: (value) {

                          return
                            context
                                .read<LoginCubit>()
                                .loginModel
                                .error_password.isNotEmpty?
                            context
                                .read<LoginCubit>()
                                .loginModel
                                .error_password:null;
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
              SizedBox(height: 20,),
              Text('forgot your password?'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppColors.primary),)
             ,
              SizedBox(height: 20,),
              CustomButton(
                textcolor: AppColors.color1,
                text: AppStrings.signInBtn,
                color:   context.read<LoginCubit>().isLoginValid?AppColors.primary:AppColors.gray,

                onClick: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginCubit>().userLogin();
                    print('all is well !!');
                  }
                },
                paddingHorizontal: 60,
                borderRadius: 80,
              ),
              SizedBox(height: 20,),
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: 'Don’t have an  account? ',style: new TextStyle(fontWeight: FontWeight.bold,color: AppColors.color2,fontSize: 16)),
                new TextSpan(text: 'Sign Up', style: new TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary,fontSize: 16)),
              ],
            )),
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
