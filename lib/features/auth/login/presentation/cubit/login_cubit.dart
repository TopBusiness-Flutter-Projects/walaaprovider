import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/features/auth/login/models/login_model.dart';

import '../../../../../core/remote/service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/toast_message_method.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginModel loginModel = LoginModel();
  bool isLoginValid = false;

  String? message;

  LoginCubit(this.serviceApi) : super(LoginInitial()) {
    checkValidLoginData();
  }

  final ServiceApi serviceApi;

  List<String> countriesListData = [];

/////////////// Methods /////////////////

//////////////////////////////////////

  userLogin(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      final response = await serviceApi.userLogin(loginModel);

      if (response.status.code == 200) {
        Navigator.pop(context);
        storeUser(response);

        Future.delayed(Duration(milliseconds: 400), () {

          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.NavigationBottomRoute,
            ModalRoute.withName(Routes.loginRoute),
          );
        });

      } else if (response.status.code == 406) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "invaild pass".tr(),  // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM,    // location
            timeInSecForIosWeb: 1               // duration
        );
      }

      else if (response.status.code == 422) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "invaild phone".tr(),  // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM,    // location
            timeInSecForIosWeb: 1               // duration
        );
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(LoginError());
      throw errorMessage;
    }
  }
  Future<void> storeUser(UserDataModel userDataModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(loginModel));
    print('Successfully Saved User');
  }
  Future<void> checkValidLoginData() async {
    bool vaild = await loginModel.isDataValid();
    if (vaild) {
      isLoginValid = true;
      emit(OnLoginVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }
}
