import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/widget/category_list.dart';
import 'package:walaaprovider/features/mainScreens/menupage/widget/product_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    context.read<MenuCubit>().setlang(lang);
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Perfect way to start your day",
              style: TextStyle(
                  color: AppColors.color2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            CategoryList(),
            Text(
              "Perfect way to start your day",
              style: TextStyle(
                  color: AppColors.color2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            ProductList()
          ],
        ),
      ),
    );
  }
}
