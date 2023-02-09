import 'package:bloc/bloc.dart';
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
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final ServiceApi serviceApi;

   UserModel? userModel;

  PaymentCubit(this.serviceApi) : super(PaymentInitial()) {
    getUserData().then((value) => userModel=value!);
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  confirmOrder(OrderModel model, String user_id, BuildContext context) async {
    try {

      StatusResponse response = await serviceApi.confirmOrder(
          userModel!.access_token, model.id, user_id);
      if (response.code == 200) {
        // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
        context.read<OrderCubit>().getorders(userModel);
        Navigator.pop(context);
      } else {
        toastMessage(response.message, AppColors.primary);

      }
    } catch (e) {
      toastMessage(e.toString(), AppColors.primary);
      //  Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }
}
