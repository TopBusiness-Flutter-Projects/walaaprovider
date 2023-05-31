import 'dart:async';

import 'package:easy_localization/easy_localization.dart' as translate;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/core/widgets/custom_button.dart';
import 'package:walaaprovider/features/auth/newpassword/model/new_password_model.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';
import '../widgets/header_title.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key, required this.phone,required this.orderModel})
      : super(key: key);
  final String phone;
  final OrderModel orderModel;

  @override
  State<VerificationScreen> createState() =>
      _VerificationScreenState(phone: phone);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final formKey = GlobalKey<FormState>();
  String phone;

  _VerificationScreenState({required this.phone});

  bool hasError = false;

  StreamController<ErrorAnimationType>? errorController;

  String currentText = "";

  @override
  void initState() {
    super.initState();
    // if(context.read<RegisterCubit>().phone.isNotEmpty){
    // context.read<RegisterCubit>().startTimer();
    // }
  }

  @override
  void dispose() {
    errorController!.close();
    // textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    errorController = StreamController<ErrorAnimationType>();
    context.read<VerficationCubit>().phoneController.text = phone;
    // context..read<VerficationCubit>().sendSmsCode();
    String lang = translate.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<VerficationCubit, VerficationState>(
          builder: (context, state) {
            if (state is CheckCodeSuccessfully) {
              Future.delayed(const Duration(milliseconds: 500), () async {
                toastMessage(
                  'Success',
                  context,
                  color: AppColors.success,
                );
                UserModel userModel = await Preferences.instance.getUserModel();
                if (userModel.user.isLoggedIn) {
                  if(widget.orderModel.id==0){
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.NavigationBottomRoute,
                      ModalRoute.withName(Routes.verficationRoute));}
                  else{
context.read<VerficationCubit>().confirmOrder(widget.orderModel,widget.orderModel.userData.id.toString(),context);

                  }
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.newpassRoute,
                      ModalRoute.withName(Routes.loginRoute),
                      arguments: context.read<VerficationCubit>().model);
                }
              });

              // return const ShowLoadingIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      HeaderTitleWidget(
                        title: translate.tr('verification_title_text'),
                        des: translate.tr('verification_desc_text'),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 30,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              backgroundColor: AppColors.white,
                              hintCharacter: '-',
                              textStyle: TextStyle(color: AppColors.primary),
                              hintStyle: TextStyle(color: AppColors.primary),
                              pastedTextStyle: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              appContext: context,
                              length: 6,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 5) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                inactiveColor: AppColors.transparent,
                                activeColor: AppColors.transparent,
                                shape: PinCodeFieldShape.box,
                                selectedColor: AppColors.transparent,
                              ),
                              cursorColor: AppColors.primary,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              errorAnimationController: errorController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError
                              ? translate.tr('verification_validator_message')
                              : "",
                          style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: translate.tr('done_btn'),
                        color: AppColors.buttonBackground,
                        paddingHorizontal: 40,
                        borderRadius: 30,
                        onClick: () {
                          formKey.currentState!.validate();
                          if (currentText.length != 6) {
                            errorController!.add(
                              ErrorAnimationType.shake,
                            ); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            setState(
                              () {
                                hasError = false;
                                context
                                    .read<VerficationCubit>()
                                    .verifySmsCode(currentText);
                              },
                            );
                          }
                        },
                        textcolor: AppColors.color1,
                      ),
                      const SizedBox(height: 12),
                      // Align(
                      //   alignment: lang == 'en'
                      //       ? Alignment.centerRight
                      //       : Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal:
                      //             MediaQuery.of(context).size.width / 8),
                      //     child: TextButton(
                      //       onPressed: () => Navigator.pop(context),
                      //       style: TextButton.styleFrom(
                      //         foregroundColor: AppColors.primary, // Text Color
                      //       ),
                      //       child: Text(
                      //         translate.tr('back_btn'),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 30),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      ImageAssets.verificationImage,
                      height: 180,
                      width: 210,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
