import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/utils/circle_network_image.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.model, required this.index}) : super(key: key);
  final CategoryModel model;
final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
              child: ManageCircleNetworkImage(
                imageUrl: model.image,
                height: 120,
                width: 120,
              ),
            ),
            Text(
              model.name,
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.color2,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(

                    child: Icon(
                      Icons.edit_calendar_outlined,
                      color: AppColors.onBoardingColor,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.addCategoryRoute,arguments: model);

                    },
                  ),
                  InkWell(
                    onTap: () {
                      context.read<HomeCubit>().deleteCategory(model,index);
                    },
                    child: MySvgWidget(
                      path: ImageAssets.removeIcon,
                      color: AppColors.onBoardingColor,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
