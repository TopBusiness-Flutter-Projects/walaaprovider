import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/recharge_wallet_model.dart';
import 'package:walaaprovider/core/models/settings.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/features/splash/presentation/screens/splash_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserModel? userModel;
  final ServiceApi serviceApi;
  late SettingModel settingModel;

  ProfileCubit(this.serviceApi) : super(ProfileInitial()) {
    getUserData();
    getSettings();
  }

  getSettings() async {
    final response = await serviceApi.getsetting();
    if (response.code == 200) {
      settingModel = response;
      emit(SettingsLoaded(response));
    } else {
      emit(SettingsError());
    }
  }

  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    emit(OnDataLoaded(userModel!));
  }

  onGetProfileData() async {
    print('000000000000');
    print('000000000000');
    var response = await serviceApi.getProfileByToken(userModel!.access_token);
    print(response.status.code);
    if (response.status.code == 200) {
      onRechargeDone(response);
    }
  }

  onRechargeDone(UserDataModel userDataModel) async {
    userDataModel.userModel.access_token = userModel!.access_token;
    await Preferences.instance.setUser(userDataModel.userModel);
    getUserData();
  }

  deleteAccount(BuildContext context) async {
    try {
      StatusResponse response =
          await serviceApi.deleteAccount(userModel!.access_token);
      if (response.code == 200) {
        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
        // context.read<OrderCubit>().getorders(userModel);
        //   Navigator.pop(context);
        toastMessage('sucess'.tr(), AppColors.primary);

        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 1300),
            child: SplashScreen(),
          ),
          ModalRoute.withName(
            Routes.loginRoute,
          ),
        );
      } else {
        toastMessage(response.message, AppColors.primary);
      }
    } catch (e) {
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }

  onRechargeWallet(double amount, BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      final response =
          await serviceApi.chargeWallet(userModel!.access_token, amount);
      if (response.code == 200) {
        Navigator.pop(context);
        emit(OnUrlPayLoaded(response));
      }
      else {
        Navigator.pop(context);
        toastMessage(response.message, context);
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      //emit(OnAddProductError());
      throw errorMessage;
    }
  }
}
