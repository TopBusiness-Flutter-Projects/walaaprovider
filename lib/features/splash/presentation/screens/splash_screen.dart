import 'dart:async';
import 'dart:convert';

import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  bool isupdate = false;

  bool isbig = false;

  _startDelay() async {
    // if (await Permission.location.request().isDenied) {
    //   Map<Permission, PermissionStatus> statuses = await [
    //     Permission.location,
    //   ].request();
    //   print(statuses[Permission.location]);
    // }
    // if (await Permission.storage.request().isDenied) {
    //   Map<Permission, PermissionStatus> statuses = await [
    //     Permission.storage,
    //   ].request();
    //   print(statuses[Permission.storage]);
    // }
    await Future.delayed(const Duration(milliseconds: 300), () => _updateSize())
        .then((value) => setState(() {
              Future.delayed(
                  const Duration(milliseconds: 2000),
                  () => setState(() {
                        isbig = true;
                      }));
            }))
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, Routes.NavigationBottomRoute, (route) => false));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _updateSize() {
    print("lllll");
    setState(() {
      isupdate = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: AnimatedSize(
        curve: Curves.easeIn,
        duration: const Duration(seconds: 4),
        child: Container(
          width: isupdate ? double.maxFinite : 200,
          height: isupdate ? double.maxFinite : 200,
          decoration: BoxDecoration(
              color: AppColors.primary,
              shape: isbig ? BoxShape.rectangle : BoxShape.circle),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  // child: Image.asset(
                  //   height: 90,
                  //   width: 90,
                  //   ImageAssets.cofeeLogo,
                  // ),
                  child: Center(
                      child: Text(
                    'Wala Coffee',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  )),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
