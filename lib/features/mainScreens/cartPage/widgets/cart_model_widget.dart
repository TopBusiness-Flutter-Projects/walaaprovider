import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/product_model.dart';

import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/cart_cubit.dart';

class CartModelWidget extends StatefulWidget {
  CartModelWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProductModel model;

  @override
  State<CartModelWidget> createState() => _CartModelWidgetState();
}

class _CartModelWidgetState extends State<CartModelWidget> {
  int totalPrice = 0;

  Future<void> changeItemCount(String type, context) async {
    if (type == '+') {
      widget.model.quantity++;
      Preferences.instance.changeProductCount(
        widget.model,
        widget.model.quantity,
        widget.model.price!,
        context,
      );
      setState(() {});
    } else {
      if (widget.model.quantity > 1) {
        widget.model.quantity--;
        Preferences.instance.changeProductCount(
          widget.model,
          widget.model.quantity,
          -(widget.model.price)!,
          context,
        );
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    totalPrice = (widget.model.quantity * widget.model.price!) ;
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Card(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SizedBox(
                  width: null,
                  height: null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: CachedNetworkImage(
                              imageUrl: widget.model.image!,
                              imageBuilder: (context, imageProvider) {
                                return CircleAvatar(
                                  backgroundImage: imageProvider,
                                );
                              },
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  widget.model.name!,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${totalPrice} SAR',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: null,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              changeItemCount('+', context)
                                                  .whenComplete(() => context
                                                      .read<CartCubit>()
                                                      .getTotalPrice());
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Text(
                                            '${widget.model.quantity}',
                                            style: TextStyle(
                                                color: AppColors.white),
                                          ),
                                          SizedBox(width: 16),
                                          InkWell(
                                            onTap: () {
                                              changeItemCount('-', context)
                                                  .whenComplete(() => context
                                                  .read<CartCubit>()
                                                  .getTotalPrice());
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
