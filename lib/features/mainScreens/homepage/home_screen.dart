import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/homepage/widget/category_list.dart';
import 'package:walaaprovider/features/mainScreens/homepage/widget/product_list.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    context.read<HomeCubit>().setlang(lang);
    context.read<MenuCubit>().setlang(lang);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addProductRoute,arguments: ProductModel(id: 0,image: ''));

        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        children: [
          Text(
            "prefect_way".tr(),
            style: TextStyle(
                color: AppColors.color2,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          CategoryList(),
          Text(
            "choose_cofe".tr(),
            style: TextStyle(
                color: AppColors.color2,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          ProductList()
        ],
      ),
    );
  }
}
