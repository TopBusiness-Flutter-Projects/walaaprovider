import 'package:flutter/material.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/circle_network_image.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.model}) : super(key: key);
  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
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

        )
      ],
    );
  }
}
