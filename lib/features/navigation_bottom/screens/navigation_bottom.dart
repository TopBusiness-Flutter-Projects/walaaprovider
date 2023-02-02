import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/my_svg_widget.dart';
import 'package:walaaprovider/features/mainScreens/homepage/home_screen.dart';
import 'package:walaaprovider/features/mainScreens/menupage/screens/menu_screen.dart';
import 'package:walaaprovider/features/mainScreens/profilepage/presentation/screens/profile.dart';

import '../../mainScreens/cartPage/screens/cart_page.dart';
import '../cubit/navigator_bottom_cubit.dart';
import '../widget/navigator_bottom_widget.dart';

class NavigationBottom extends StatefulWidget {
  NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
        builder: (context, state) {
      String lang = EasyLocalization.of(context)!.locale.languageCode;
      NavigatorBottomCubit bottomCubit=  context.read<NavigatorBottomCubit>();
      return Scaffold(
          appBar: AppBar(
              backgroundColor: bottomCubit.page == 0 ||
                      bottomCubit.page == 2
                  ? AppColors.color1
                  : bottomCubit.page == 3
                      ? AppColors.white
                      : AppColors.grey8,
              elevation: 0,
              title: bottomCubit.page == 0 ||
                      bottomCubit.page == 2
                  ? Center(
                      child: Text(
                      bottomCubit.title,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
                  : Row(
                      children: [
                        Text(bottomCubit.title,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Container(),
                        ),

                        Visibility(
                          visible: bottomCubit.page == 3?true:false,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: InkWell(
                              onTap: () {
                                bottomCubit.changePage(0,'home'.tr());;
                              },
                              child: Transform.rotate(
                                  angle: lang == 'en'
                                      ? (180 * (3.14 / 180))
                                      : (0 * (3.14 / 180)),
                                  child: MySvgWidget(
                                    path:
                                        bottomCubit.page == 3
                                            ? ImageAssets.closeIcon
                                            : ImageAssets.arrowIcon,
                                    color: bottomCubit.page != 3?AppColors.primary:null,
                                    width: bottomCubit.page == 3
                                        ?40: 24,
                                    height: bottomCubit.page == 3?
                                        40: 24,
                                  )),
                            ),
                          ),
                        ),

                      ],
                    )),
          bottomNavigationBar: SizedBox(
            height: 60,
            child: NavigatorBottomWidget(),
          ),
          body: BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
            builder: (context, state) {
              if (bottomCubit.page == 2) {
                return MenuScreen();
              } else if (bottomCubit.page == 1) {
                return Container();
              } else if (bottomCubit.page == 3) {
                return ProfileScreen();
              } else if (bottomCubit.page == 4) {
                return CartPage();
              } else {
                return HomeScreen();
              }
              // else if (bottomCubit.page == 1) {
              //   return CalenderScreen();
              //  } else if (bottomCubit.page == 2) {
              //    return Container(color: AppColors.color1,);
              //  } else {
              //    return DrawerWidget();
            },
          ));
    });
  }
}
