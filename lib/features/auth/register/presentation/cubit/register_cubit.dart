import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user_data_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/features/auth/register/models/register_model.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';

import '../../../../../core/remote/service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/toast_message_method.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterModel registerModel = RegisterModel();
  bool isRegisterValid = false;

  String? message;

  RegisterCubit(this.serviceApi) : super(RegisterInitial()) {
    checkValidRegisterData();
  }

  final ServiceApi serviceApi;

  List<String> countriesListData = [];

/////////////// Methods /////////////////

//////////////////////////////////////

  userRegister(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      final response = await serviceApi.userRegister(registerModel);

      if (response.status.code == 200) {
        Navigator.pop(context);
        Preferences.instance.setUser(response.userModel).then((value) =>
            Future.delayed(Duration(milliseconds: 10), () {
              context.read<VerficationCubit>().phoneController.text=registerModel.phone_code+registerModel.phone;
              context.read<VerficationCubit>().sendSmsCode();

            }).then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.verficationRoute,
                    ModalRoute.withName(Routes.registerRoute),
                    arguments: [registerModel.phone_code+registerModel.phone,null]
                )));



      }

      else if (response.status.code == 409) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "invaild phone".tr(), // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
            timeInSecForIosWeb: 1 // duration
            );
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(RegisterError());
      throw errorMessage;
    }
  }



  Future<void> checkValidRegisterData() async {
    bool vaild = await registerModel.isDataValid();
    if (vaild) {
      isRegisterValid = true;
      emit(OnRegisterVaild());
    } else {
      isRegisterValid = false;

      emit(OnRegisterVaildFaild());
    }
  }
}
