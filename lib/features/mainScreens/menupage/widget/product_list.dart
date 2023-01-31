import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/product_model.dart';
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
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        MenuCubit menuCubit = context.read<MenuCubit>();
        print(menuCubit.productLength);
        List<ProductModel> list = [];
        if (menuCubit.productList.isNotEmpty) {
          list = menuCubit.productList;
        }
        print("ssss${list.length}");

        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .8,
            mainAxisSpacing: 1,
            crossAxisCount: 2,
          ),
          itemCount: list.length > 0 ? list.length : menuCubit.productLength,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: state is AllProductLoading
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
                      : menuCubit.productList.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.all(25.0),
                              child: ProductWidget(
                                model: context
                                    .read<MenuCubit>()
                                    .productList
                                    .elementAt(index),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
            );
          },
        );
      },
    );
  }
}
