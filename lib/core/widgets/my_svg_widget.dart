import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_colors.dart';

// ignore: must_be_immutable
class MySvgWidget extends StatelessWidget {
  MySvgWidget({
    Key? key,
    required this.path,
    this.width = 16.0,
    this.height = 16.0,
    this.color,
  }) : super(key: key);

  final String path;
  final double? width;
  final double? height;
  Color? color = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      color: color,
    );
  }
}
