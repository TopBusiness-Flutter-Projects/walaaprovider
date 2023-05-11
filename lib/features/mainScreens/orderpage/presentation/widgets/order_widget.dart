import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/widgets/outline_button_widget.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';

class OrderItem extends StatefulWidget {
  final OrderModel orderModel;
  const OrderItem({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
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
                "name".tr()+":${widget.orderModel.userData.name}",
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
                "total_price".tr()+":${widget.orderModel.totalPrice}",
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
                "date".tr()+":${widget.orderModel.dataTime}",
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
                    showConfirmCodeDialog(widget.orderModel.totalPrice.toString());
//Navigator.pushNamed(context, Routes.paymentqrRoute,arguments:widget.orderModel );
                  },
                ),
                Spacer(),
                OutLineButtonWidget(
                  text:'cancel'.tr(),
                  borderColor: AppColors.error,
                  onclick: () {
                    context.read<OrderCubit>().caneclOrder(widget.orderModel,context);
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

  showConfirmCodeDialog(String price) {

    double height = MediaQuery.of(context).size.height * .5;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              padding: const EdgeInsets.only(top: 16.0),
              color: AppColors.white,
              child: SingleChildScrollView(child: Column(
                children: [


                  Icon(
                    size: 30,
            Icons.check_circle,
                  color: AppColors.success,

                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'will_deducted'.tr()+price+"your_account".tr(),
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      OutLineButtonWidget(
                        text: 'confirm'.tr(),
                        borderColor: AppColors.success,
                        onclick: () {
                          Future.delayed(Duration(milliseconds: 400), () {
                            context.read<VerficationCubit>().phoneController.text=widget.orderModel.userData.phone_code+widget.orderModel.userData.phone;
                            context.read<VerficationCubit>().sendSmsCode();

                          })
                          .then((value) => {
                            Navigator.pop(context),
                            Navigator.pushNamed(context, Routes.verficationRoute,arguments:[widget.orderModel.userData.phone_code+widget.orderModel.userData.phone,widget.orderModel] )
                          });
                        },
                      ),
                      Spacer(),
                      OutLineButtonWidget(
                        text:'cancel'.tr(),
                        borderColor: AppColors.error,
                        onclick: () {


                            Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),),
            ),
          );
        });
  }
}
