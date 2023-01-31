import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/network_image.dart';
import 'package:walaaprovider/core/widgets/show_loading_indicator.dart';
import 'package:walaaprovider/features/auth/register/presentation/screens/register.dart';
import 'package:walaaprovider/features/splash/presentation/screens/splash_screen.dart';

import '../cubit/profile_cubit.dart';
import '../widgets/profile_lsit_tail_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          ProfileCubit profileCubit = context.read<ProfileCubit>();
          return profileCubit.userModel == null
              ? ShowLoadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 3 - 60,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.transparent,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                                vertical: 25,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    ),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.color1,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Icon(
                                        Icons.edit_calendar_outlined,
                                        color: AppColors.primary,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 10,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              width: 90,
                              height: 120,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                child: ClipOval(
                                  child: ManageNetworkImage(
                                    imageUrl:
                                        profileCubit.userModel!.user.image!,
                                    width: 140,
                                    height: 140,
                                    borderRadius: 140,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            left: 0,
                            child: Column(
                              children: [
                                Text(
                                  'welcome'.tr()+" "+('appname'.tr()),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextButton(
                                  onPressed: () async {
                                    bool result =
                                        Preferences.instance.clearUserData();
                                    result
                                        ? Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 1300),
                                              child: SplashScreen(),
                                            ),
                                            ModalRoute.withName(
                                                Routes.loginRoute))
                                        : null;
                                  },
                                  child: Text(
                                    'logout'.tr(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ProfileListTailWidget(
                        title: 'balance'.tr() +
                            " , " +
                            profileCubit.userModel!.user.balance.toString() +
                            "sr".tr(),
                        image: ImageAssets.walletIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () {},

                        //     Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PrivacyAndTermsScreen(
                        //         title: AppStrings.privacyText),
                        //   ),
                        // ),
                      ),
                      ProfileListTailWidget(
                        title: 'addcategory'.tr(),
                        image: ImageAssets.addIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () {
                          Navigator.pushNamed(context, Routes.addCategoryRoute,arguments: CategoryModel.name(0, '', ''));
                        },

                        //     Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PrivacyAndTermsScreen(
                        //         title: AppStrings.privacyText),
                        //   ),
                        // ),
                      ),
                      ProfileListTailWidget(
                        title: 'privacy'.tr(),
                        image: ImageAssets.privacyIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () {
                          Navigator.pushNamed(
                              context,
                              Routes.termsprivacyRoute,

                              arguments: 'privacy'
                          );
                        },

                        //     Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PrivacyAndTermsScreen(
                        //         title: AppStrings.privacyText),
                        //   ),
                        // ),
                      ),
                      ProfileListTailWidget(
                        title: 'delete_account'.tr(),
                        image: ImageAssets.removeIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () {},
                      ),
                      SizedBox(
                        width:double.maxFinite,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () => {},
                                  child: Image.asset(
                                    ImageAssets.whatsappImage,
                                    width: 55.0,
                                    height: 55.0,
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(
                                width: 16.0,
                              ),
                              InkWell(
                                  onTap: () => {},
                                  child: Image.asset(
                                    ImageAssets.instagramImage,
                                    width: 40.0,
                                    height: 40.0,
                                    fit: BoxFit.cover,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
