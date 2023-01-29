import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';
import 'package:walaaprovider/features/mainScreens/menupage/menu_screen.dart';

import '../cubit/navigator_bottom_cubit.dart';
import '../widget/navigator_bottom_widget.dart';

class NavigationBottom extends StatefulWidget {
  NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  //
  // shared() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   print('doooooooooooooooooooooooooooooooooooooooone');
  // }

  @override
  void initState() {
    // shared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
        builder: (context, state) {
      String lang = EasyLocalization.of(context)!.locale.languageCode;

      return Scaffold(
          appBar: AppBar(
              backgroundColor: context.read<NavigatorBottomCubit>().page == 0 ||
                      context.read<NavigatorBottomCubit>().page == 2
                  ? AppColors.color1
                  : context.read<NavigatorBottomCubit>().page == 3
                      ? AppColors.white
                      : AppColors.grey8,
              elevation: 0,
              title: context.read<NavigatorBottomCubit>().page == 0 ||
                      context.read<NavigatorBottomCubit>().page == 2
                  ? Center(
                      child: Text(
                      context.read<NavigatorBottomCubit>().title,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
                  : Row(
                      children: [
                        Transform.rotate(
                            angle: lang == 'en'
                                ? (180 * (3.14 / 180))
                                : (0 * (3.14 / 180)),
                            child: MySvgWidget(
                              path:
                                  context.read<NavigatorBottomCubit>().page == 3
                                      ? ImageAssets.closeIcon
                                      : ImageAssets.arrowIcon,
                              color: context.read<NavigatorBottomCubit>().page != 3?AppColors.primary:null,
                              width: 24,
                              height: 24,
                            )),
                        Expanded(
                          child: Container(),
                        ),
                        Text(context.read<NavigatorBottomCubit>().title,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
          bottomNavigationBar: SizedBox(
            height: 60,
            child: NavigatorBottomWidget(),
          ),
          body: BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
            builder: (context, state) {
              if (context.read<NavigatorBottomCubit>().page == 2) {
                return MenuScreen();
              } else if (context.read<NavigatorBottomCubit>().page == 1) {
                return Container();
              } else if (context.read<NavigatorBottomCubit>().page == 3) {
                return Container();
              } else if (context.read<NavigatorBottomCubit>().page == 4) {
                return Container();
              } else {
                return Container();
              }
              // else if (context.read<NavigatorBottomCubit>().page == 1) {
              //   return CalenderScreen();
              //  } else if (context.read<NavigatorBottomCubit>().page == 2) {
              //    return Container(color: AppColors.color1,);
              //  } else {
              //    return DrawerWidget();
            },
          ));
    });
  }
}
