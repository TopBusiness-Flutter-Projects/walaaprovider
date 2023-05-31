import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/toast_message_method.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/my_svg_widget.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  String _verticalGroupValue = "cafe".tr();

  final _status = ["cafe".tr(), "restuarant".tr()];

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
        backgroundColor: AppColors.grey8,
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterErrorMessages) {
              toastMessage(
                context.read<RegisterCubit>().message,
                context,
                color: AppColors.error,
              );
            }
            if (state is RegisterError) {
              toastMessage(
                context.read<RegisterCubit>().message,
                context,
                color: AppColors.error,
              );
            }
            if (state is OnRegisterVaildFaild) {
              formKey.currentState!.validate();
            }
            if (state is OnRegisterVaild) {
              formKey.currentState!.validate();
            }
          },
          child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
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
                        Text("welcom_coffee".tr(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "get_wide_range".tr(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                        SizedBox(
                          height: 23,
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
                                  onChanged: (data) {
                                    context
                                        .read<RegisterCubit>()
                                        .registerModel.
                                        name = data;
                                    context
                                        .read<RegisterCubit>()
                                        .checkValidRegisterData();
                                  },
                                  validator: (value) {
                                    return context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .error_name
                                            .isNotEmpty
                                        ? context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .error_name
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
                              Expanded(
                                child: InternationalPhoneNumberInput(
                                  locale: lang,

                                  errorMessage: context
                                      .read<RegisterCubit>()
                                      .registerModel
                                      .error_phone,
                                  isEnabled: true,

                                  onInputChanged: (PhoneNumber number) {
                                    print("sssss${number.phoneNumber}");
                                    context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .phone =
                                        number.phoneNumber!
                                            .replaceAll(number.dialCode!, "")!;
                                    context
                                      ..read<RegisterCubit>()
                                          .registerModel
                                          .code = number.isoCode!;
                                    context
                                        .read<RegisterCubit>()
                                        .registerModel
                                        .phone_code = number.dialCode!;
                                    context
                                        .read<RegisterCubit>()
                                        .checkValidRegisterData();
                                  },

                                  onInputValidated: (bool value) {
                                    print("sssss${value}");
                                  },
                                  autoFocusSearch: true,

                                  initialValue: PhoneNumber(
                                      isoCode: context
                                              .read<RegisterCubit>()
                                              .registerModel
                                              .code
                                              .isNotEmpty
                                          ? context
                                              .read<RegisterCubit>()
                                              .registerModel
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
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  cursorColor: AppColors.primary,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (data) {
                                    context
                                        .read<RegisterCubit>()
                                        .registerModel
                                        .location = data;
                                    context
                                        .read<RegisterCubit>()
                                        .checkValidRegisterData();
                                  },
                                  validator: (value) {
                                    return context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .error_location
                                            .isNotEmpty
                                        ? context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .error_location
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
                                    context
                                        .read<RegisterCubit>()
                                        .registerModel
                                        .password = data;
                                    context
                                        .read<RegisterCubit>()
                                        .checkValidRegisterData();
                                  },
                                  validator: (value) {
                                    return context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .error_password
                                            .isNotEmpty
                                        ? context
                                            .read<RegisterCubit>()
                                            .registerModel
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
                                    context
                                        .read<RegisterCubit>()
                                        .registerModel
                                        .confirm_password = data;
                                    context
                                        .read<RegisterCubit>()
                                        .checkValidRegisterData();
                                  },
                                  validator: (value) {
                                    return context
                                            .read<RegisterCubit>()
                                            .registerModel
                                            .error_confirm_password
                                            .isNotEmpty
                                        ? context
                                            .read<RegisterCubit>()
                                            .registerModel
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
                        Container(

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Radio(
                                        groupValue: _verticalGroupValue=='cafe'.tr()?_verticalGroupValue:"",
                                        value: 'cafe'.tr(),
                                        onChanged: (value) => setState(() {
                                          print("value");
                                          _verticalGroupValue = value ?? '';

                                          print(value);
                                          context
                                                  .read<RegisterCubit>()
                                                  .registerModel.provider_id=
                                                2;
                                        }),
                                      ),
                                      Text('cafe'.tr()),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                    title: Row(
                                  children: [
                                    Radio(

                                      groupValue: _verticalGroupValue=='restuarant'.tr()?_verticalGroupValue:"",
                                      value: 'restuarant'.tr(),

                                      onChanged: (value) => setState(() {
                                        print("value");
                                        _verticalGroupValue = value ?? '';

                                        print(value);
                                        context
                                                .read<RegisterCubit>()
                                                .registerModel
                                                .provider_id =
                                         1;
                                      }),
                                    ),
                                    Text('restuarant'.tr()),
                                  ],
                                )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          textcolor: AppColors.color1,
                          text: 'sign_up'.tr(),
                          color: context.read<RegisterCubit>().isRegisterValid
                              ? AppColors.buttonBackground
                              : AppColors.gray,
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<RegisterCubit>()
                                  .userRegister(context);
                              print('all is well !!');
                            }
                          },
                          paddingHorizontal: 60,
                          borderRadius: 80,
                        ),
                        SizedBox(height: 20),

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
