import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:bloc/bloc.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'dart:async';

import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ServiceApi serviceApi;

  bool isForgotPasswordValid = false;

  late String phone;

  ForgotPasswordCubit(this.serviceApi) : super(ForgotPasswordInitial());

  void forgotPassword(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      var response = await serviceApi.getClient(phone);

      Navigator.pop(context);
      if (response.status.code == 200) {
        emit(OnForgotPasswordSuccess(response.userModel));
      } else {
        Fluttertoast.showToast(
            msg: 'invaild phone'.tr(), // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
            timeInSecForIosWeb: 1 // duration
            );

        print("errorCode=>${response.status}");
      }
    } catch (e) {
      print("error${e.toString()}");
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

  void checkValidForgotPasswordData() {
    if (phone.isNotEmpty) {
      isForgotPasswordValid = true;
      print("ssllslsl");
      print(isForgotPasswordValid);
      emit(OnForgotPasswordVaild());
    } else {
      isForgotPasswordValid = false;

      emit(OnForgotPasswordVaildFaild());
    }
  }
}
