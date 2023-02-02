import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/widgets/order_list.dart';
import 'package:walaaprovider/features/navigation_bottom/cubit/navigator_bottom_cubit.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    context.read<OrderCubit>().setlang(lang);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NavigatorBottomCubit>().changePage(2, "order".tr());
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
          height: double.infinity, color: AppColors.grey8, child: OrderList()),
    );
  }
}
