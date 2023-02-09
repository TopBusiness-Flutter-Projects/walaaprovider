import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/widgets/outline_button_widget.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';

class OrderItem extends StatelessWidget {
  final OrderModel orderModel;
  const OrderItem({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 3,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "name".tr()+":${orderModel.userData.name}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: Text(
                "total_price".tr()+":${orderModel.totalPrice}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: Text(
                "date".tr()+":${orderModel.dataTime}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Spacer(),
                OutLineButtonWidget(
                  text: 'confirm'.tr(),
                  borderColor: AppColors.success,
                  onclick: () {
Navigator.pushNamed(context, Routes.paymentqrRoute,arguments:orderModel );
                  },
                ),
                Spacer(),
                OutLineButtonWidget(
                  text:'cancel'.tr(),
                  borderColor: AppColors.error,
                  onclick: () {
                    context.read<OrderCubit>().caneclOrder(orderModel,context);
                  //  Navigator.pop(context);
                  },
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),

    );
  }
}
