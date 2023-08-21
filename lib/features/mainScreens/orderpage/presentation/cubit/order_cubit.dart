import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/models/status_resspons.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';

import '../../../../../core/utils/appwidget.dart';
import '../../../profilepage/presentation/cubit/profile_cubit.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  List<OrderModel> orderList = [];
  late int odersize = 0;
  final ServiceApi serviceApi;

   UserModel? userModel;
  late String lang;

  OrderCubit(this.serviceApi) : super(OrderInitial()) {
    getUserData().then((value) => getorders(value));
  }

  setlang(String lang) {
    this.lang = lang;
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  getorders(UserModel? usermodel) async {
    odersize = 1;
    emit(AllOrderLoading());
    final response = await serviceApi.getOrders(usermodel!.access_token, lang);
    if (response.status.code == 200) {
      print(response.data);
      odersize=response.data.length;
      orderList = response.data!;
      emit(AllOrderLoaded(orderList));
    } else {
      print(response.status.message);
      emit(AllOrderError());
    }
  }
  caneclOrder(OrderModel model, BuildContext context) async {
    try {
      StatusResponse response = await serviceApi.cancelOrder(
          userModel!.access_token, model.id);
      if (response.code == 200) {
        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
        context.read<OrderCubit>().getorders(userModel);
       // Navigator.pop(context);
      } else {
        toastMessage(response.message, AppColors.primary);

      }
    } catch (e) {
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
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
