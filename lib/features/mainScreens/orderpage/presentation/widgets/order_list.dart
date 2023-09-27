import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/widgets/order_widget.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        OrderCubit orderCubit = context.read<OrderCubit>();

        // if(context.read<OrderCubit>().OrderList.length>0){
        //
        //  OrderCubit().getProduct(context.read<OrderCubit>().userModel,OrderCubit().OrderList.elementAt(0).id);
        //
        // }
        return RefreshIndicator(

          onRefresh: () async{
            orderCubit.getorders(orderCubit.userModel);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  orderCubit.odersize,
                  (index) => state is AllOrderLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width - 70,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : state is AllOrderError
                          ? Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.refresh),
                              ),
                            )
                          : orderCubit.orderList.isNotEmpty
                              ? InkWell(
                                  onTap: () {

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: OrderItem(
                                      orderModel: orderCubit.orderList
                                          .elementAt(index),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
