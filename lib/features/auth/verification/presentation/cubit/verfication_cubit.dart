import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/features/auth/newpassword/model/new_password_model.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';
import 'package:walaaprovider/features/mainScreens/profilepage/presentation/cubit/profile_cubit.dart';

part 'verfication_state.dart';

class VerficationCubit extends Cubit<VerficationState> {
  final ServiceApi serviceApi;

  UserModel? userModel;

  VerficationCubit(this.serviceApi) : super(VerficationInitial());
  NewPasswordModel model = NewPasswordModel();


  TextEditingController phoneController = TextEditingController();

  //////////////////send OTP///////////////////

   String phoneNumber = '';
  String smsCode = '';
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verificationId;
  int? resendToken;

  sendSmsCode() async {
    emit(SendCodeLoading());
    _mAuth.setSettings(forceRecaptchaFlow: true);
    _mAuth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber: phoneController.text,
      // timeout: Duration(seconds: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        verificationId = credential.verificationId;
        print("verificationId=>$verificationId");
        emit(OnSmsCodeSent(smsCode));
        verifySmsCode(smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(CheckCodeInvalidCode());
        print("Errrrorrrrr : ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.resendToken = resendToken;
        this.verificationId = verificationId;
        print("verificationId=>${verificationId}");
        emit(OnSmsCodeSent(''));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('kokokokokokok');
        this.verificationId = verificationId;
      },
    );
  }

  verifySmsCode(String smsCode) async {
    print(smsCode);
    print(verificationId);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) {
      print('VerificationSuccess');
      emit(CheckCodeSuccessfully());
    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }
  confirmOrder(OrderModel model, String user_id, BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      if (userModel == null) {
        userModel = await Preferences.instance.getUserModel();
      }
      StatusResponse response = await serviceApi.confirmOrder(
          userModel!.access_token, model.id, user_id);
      if (response.code == 200) {
        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
        context.read<OrderCubit>().getorders(userModel);
        context.read<ProfileCubit>().userModel=userModel;
        context.read<ProfileCubit>().onGetProfileData();
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);

        toastMessage(response.message, AppColors.primary);
      }
    } catch (e) {
      Navigator.pop(context);
      toastMessage(e.toString(), AppColors.primary);
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }

}
