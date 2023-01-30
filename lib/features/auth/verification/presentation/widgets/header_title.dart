import 'package:flutter/material.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';

class HeaderTitleWidget extends StatelessWidget {
  const HeaderTitleWidget({Key? key, required this.title, required this.des})
      : super(key: key);
  final String title;
  final String des;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          Text(
            des,
            style:  TextStyle(color: AppColors.primary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
