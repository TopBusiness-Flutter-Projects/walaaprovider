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

  List<int> _badgeCounts = List<int>.generate(5, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(5, (index) => true);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
      builder: (context, state) {
        _page = context.read<NavigatorBottomCubit>().page;
        return CustomNavigationBar(
          iconSize: 30.0,
          selectedColor: AppColors.color2,
          strokeColor: Color(0x30040307),
          unSelectedColor: AppColors.white,
          backgroundColor: AppColors.primary,
          currentIndex: _page,
          items: [
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.phoneIcon),

              showBadge: _badgeShows[0],
            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.phoneIcon),

              showBadge: _badgeShows[1],
            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.phoneIcon),

              showBadge: _badgeShows[2],
            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.phoneIcon),

              showBadge: _badgeShows[3],
            ),
            CustomNavigationBarItem(
              icon: Image.asset(ImageAssets.phoneIcon),
              badgeCount: _badgeCounts[4],
              showBadge: _badgeShows[4],
            )

          ],
          onTap: (index) {
            context.read<NavigatorBottomCubit>().changePage(index);
          },
        );
      },
    );
  }
}
