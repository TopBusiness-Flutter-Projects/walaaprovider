import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/widget/category_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          ...List.generate(

            context.read<MenuCubit>().categorLength,
              (index) => state is AllCategoryLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : state is AllCategoryError
                      ? Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.refresh),
                          ),
                        )
                      : state is AllCategoryLoaded
                          ? Padding(
                              padding: EdgeInsets.all(25.0),
                              child: CategoryWidget(
                                  model: context
                                      .read<MenuCubit>()
                                      .categoryList
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
