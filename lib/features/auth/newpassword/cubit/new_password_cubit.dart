import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/features/auth/newpassword/model/new_password_model.dart';


import 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {

  NewPasswordModel model = NewPasswordModel();
  bool isDataValid = false;
  bool ishidden=true;
  final ServiceApi api;
 

  NewPasswordCubit(this.api) : super(NewPasswordInitial()) ;


  checkData() {
    if (model.isDataValid()) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }

    emit(UserDataValidation(isDataValid));
  }
  hide() {
    print("sss${ishidden}");
    ishidden=!ishidden;
    print("seess${ishidden}");
    emit(PasswordHidden(ishidden));
  }

  newPassword(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    try {
      var response = await api.newpassword(model);
      if (response.status.code == 200) {

          Navigator.pop(context);
          emit(OnNewPasswordSuccess());

      } else {
        Navigator.pop(context);
        emit(OnError(response.status.message));
      }
    } catch (e) {
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

  // updateProfile(BuildContext context, String user_token) async {
  //   AppWidget.createProgressDialog(context, 'wait'.tr());
  //   try {
  //     UserModel response = await api.updateProfile(model, user_token);
  //     response.data.isLoggedIn = true;
  //     print("Dkdkdkdk" + response.status.status.toString());
  //     if (response.status.status == 200) {
  //       response.data.token = user_token;
  //       Preferences.instance.setUser(response).then((value) {
  //         Navigator.pop(context);
  //         emit(OnSignUpSuccess());
  //       });
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     OnError(e.toString());
  //   }
  // }

}
