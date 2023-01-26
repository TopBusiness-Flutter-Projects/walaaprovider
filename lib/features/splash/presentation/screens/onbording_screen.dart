import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('onBoarding', 'Done').then(
          (value) => Navigator.pushNamedAndRemoveUntil(
              context, Routes.loginRoute, (route) => false)
          )
        ;
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
    controller.addListener(() {
      controller.index == 0
          ? setState(() {
              index = 0;
            })
          : setState(() {
              index = 1;
            });
    });

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
  }

  late TabController controller;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [

                Stack(
                  children: [
                    Image.asset(
                      ImageAssets.boarding2Image,
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 10,
                      right: 0,
                      left: 0,
                      child: CustomButton(
                        text: 'Get Started',
                        onClick: () =>setFirstInstall(),
                        color: AppColors.buttonBackground,
                        paddingHorizontal: 130,
                        borderRadius: 20, textcolor: AppColors.color1,
                      ),
                    ),
                  ],
                ),

              ],
            ),


        ),

    );
  }
}
