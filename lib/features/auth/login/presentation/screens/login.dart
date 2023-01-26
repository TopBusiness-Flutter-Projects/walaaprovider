import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_routes.dart';
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
    String lang = EasyLocalization.of(context)!.locale.languageCode;

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
            if (state is OnLoginVaildFaild) {
              formKey.currentState!.validate();
            }
            if (state is OnLoginVaild) {
              formKey.currentState!.validate();
            }
          },
          child: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
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
                          child: Row(
                            children: [
                              MySvgWidget(
                                path: ImageAssets.phoneIcon,
                                color: AppColors.primary,
                                width: 16,
                                height: 16,
                              ),
                              Expanded(
                                child: InternationalPhoneNumberInput(
                                  locale: lang,

                                  errorMessage: context
                                      .read<LoginCubit>()
                                      .loginModel
                                      .error_phone,
                                  isEnabled: true,

                                  onInputChanged: (PhoneNumber number) {
                                    print("sssss${number.phoneNumber}");
                                    context
                                            .read<LoginCubit>()
                                            .loginModel
                                            .phone =
                                        number.phoneNumber!
                                            .replaceAll(number.dialCode!, "")!;
                                    context
                                      ..read<LoginCubit>().loginModel.code =
                                          number.isoCode!;
                                    context
                                        .read<LoginCubit>()
                                        .loginModel
                                        .phone_code = number.dialCode!;
                                    context
                                        .read<LoginCubit>()
                                        .checkValidLoginData();
                                  },

                                  onInputValidated: (bool value) {
                                    print("sssss${value}");
                                  },
                                  autoFocusSearch: true,

                                  initialValue: PhoneNumber(
                                      isoCode: context
                                              .read<LoginCubit>()
                                              .loginModel
                                              .code
                                              .isNotEmpty
                                          ? context
                                              .read<LoginCubit>()
                                              .loginModel
                                              .code
                                          : "SA"),
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
                                        .password = data;
                                    context
                                        .read<LoginCubit>()
                                        .checkValidLoginData();
                                  },
                                  validator: (value) {
                                    return context
                                            .read<LoginCubit>()
                                            .loginModel
                                            .error_password
                                            .isNotEmpty
                                        ? context
                                            .read<LoginCubit>()
                                            .loginModel
                                            .error_password
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
                        Text(
                          'forgot_password'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primary),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textcolor: AppColors.color1,
                          text: 'signin'.tr(),
                          color: context.read<LoginCubit>().isLoginValid
                              ? AppColors.primary
                              : AppColors.gray,
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginCubit>().userLogin(context);
                              print('all is well !!');
                            }
                          },
                          paddingHorizontal: 60,
                          borderRadius: 80,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'dont_have'.tr(),
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.color2,
                                    fontSize: 16)),
                            new TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  Navigator.pushNamed(context, Routes.registerRoute);
                                  },
                                text: 'sign_up'.tr(),
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: 16)),
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
