import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/widget/category_widget.dart';
import 'package:walaaprovider/features/mainScreens/menupage/widget/product_widget.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          ...List.generate(

            context.read<MenuCubit>().productLength,
              (index) => state is AllProductLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : state is AllProductError
                      ? Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.refresh),
                          ),
                        )
                      : state is AllProductLoaded
                          ? Padding(
                              padding: EdgeInsets.all(25.0),
                              child: ProductWidget(
                                  model: context
                                      .read<MenuCubit>()
                                      .productList
                                      .elementAt(index)),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )),
        ]),
      );
    });
  }
}
