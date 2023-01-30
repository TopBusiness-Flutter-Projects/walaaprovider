import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/homepage/widget/category_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit homeCubit =context.read<HomeCubit>();

      // if(homeCubit.categoryList.length>0){
      //
      //   homeCubit.getProduct(homeCubit.userModel, homeCubit.categoryList.elementAt(0).id);
      //
      // }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(

            children: [
          ...List.generate(

            homeCubit.categorLength,
              (index) => state is AllCategoryLoading
                  ? SizedBox(
                width: MediaQuery.of(context).size.width-70,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : state is AllCategoryError
                      ? Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.refresh),
                          ),
                        )
                      : homeCubit.categoryList.isNotEmpty

                          ?


              InkWell(
                onTap: () {
                  homeCubit.getProduct(homeCubit.userModel, context
                      .read<HomeCubit>()
                      .categoryList
                      .elementAt(index).id);
                },
                child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CategoryWidget(
                                    model: context
                                        .read<HomeCubit>()
                                        .categoryList
                                        .elementAt(index)),
                              ),
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
