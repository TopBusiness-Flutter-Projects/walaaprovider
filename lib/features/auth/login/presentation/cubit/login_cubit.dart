import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/remote/service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/toast_message_method.dart';
import '../../models/login_model.dart';
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

  userLogin() async {
    emit(LoginLoading());
    // try {
    //   final response = await serviceApi.userLogin(
    //     emailController.text,
    //     passwordController.text,
    //   );
    //   if (response.code == 200) {
    //     code = response.code!;
    //     message = response.message!;
    //     storeUser(response);
    //     emit(LoginLoginLoaded());
    //   } else if (response.code == 406) {
    //     errorMessage(response.message!, response.code!);
    //   }
    // } on DioError catch (e) {
    //   print(" Error : ${e}");
    //   final errorMessage = DioExceptions.fromDioError(e).toString();
    //   emit(LoginLoginError());
    //   throw errorMessage;
    // }
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
