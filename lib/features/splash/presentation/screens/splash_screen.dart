import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';

import 'onbording_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  // LoginDataModel loginDataModel = const LoginDataModel();

  _goNext() {
    _getStoreUser();
  }

  _startDelay() async {

    _timer = Timer(const Duration(milliseconds: 3000), () => _goNext());
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('onBoarding') != null) {

      if (prefs.getString('user') != null) {
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.NavigationBottomRoute,
            ModalRoute.withName(Routes.initialRoute)
        );

      }else{
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginRoute,
            ModalRoute.withName(Routes.initialRoute),
        );
      }
    }else{
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1300),
          child:  OnBoardingScreen(),
        ),
      );

    }
  }

  @override
  void initState() {
    super.initState();
     _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImageAssets.walaaLogo,
            ),
          ),
        ],
      ),
    );
  }
}
