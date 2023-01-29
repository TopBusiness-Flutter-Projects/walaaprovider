import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/features/splash/presentation/cubit/splash_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';

import 'onbording_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // LoginDataModel loginDataModel = const LoginDataModel();







  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is OnUserModelGet) {
          print("state.userModel.user.userType");
          print(state.userModel.user.userType);
          Future.delayed(const Duration(seconds: 2)).then(
                (value) => {

                    Navigator.of(context)
                        .pushReplacementNamed(Routes.NavigationBottomRoute)
                  }

          );
        }
        else if (state is NoUserFound) {
          Future.delayed(const Duration(seconds: 2)).then(
                (value) => {
              Navigator.of(context)
                  .pushReplacementNamed(Routes.loginRoute)
            },
          );
        }
        else if (state is UserFrst) {
          Future.delayed(const Duration(seconds: 2)).then(
                (value) => {
                  Navigator.pushReplacement(
                context,
                PageTransition(
                type: PageTransitionType.fade,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 1300),
                child:  OnBoardingScreen(),
                ),
                )
            },
          );
        }

      },
    builder: (context, state) {
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
      });
  }
}
