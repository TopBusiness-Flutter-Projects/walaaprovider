import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../cubit/navigator_bottom_cubit.dart';

class NavigatorBottomWidget extends StatelessWidget {
  NavigatorBottomWidget({Key? key}) : super(key: key);
  late int _page = 2;
  List<String> titles=['home'.tr(),'order'.tr(),'menu'.tr(),'profile'.tr(),'cart'.tr()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
      builder: (context, state) {
        NavigatorBottomCubit bottomCubit=  context.read<NavigatorBottomCubit>();

        _page = bottomCubit.page;
        return CustomNavigationBar(
          iconSize: 30.0,
          backgroundColor: AppColors.color1,
          strokeColor:AppColors.color2,
          currentIndex: _page,

          items: [
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.homeImage,color: _page==0?AppColors.color2:AppColors.white),

            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.orderImage,color: _page==1?AppColors.color2:AppColors.white),


            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.spoonImage,color: _page==2?AppColors.color2:AppColors.white),


            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.profileImage,color: _page==3?AppColors.color2:AppColors.white),
            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.cartImage,color: _page==4?AppColors.color2:AppColors.white),
              // badgeCount: _badgeCounts[4],
              //  showBadge: _badgeShows[4],


            )

          ],
          onTap: (index) {
            bottomCubit.changePage(index,titles.elementAt(index));
          },
        );
      },
    );
  }
}
