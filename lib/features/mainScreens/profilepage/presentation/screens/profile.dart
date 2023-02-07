import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/network_image.dart';
import 'package:walaaprovider/core/widgets/show_loading_indicator.dart';
import 'package:walaaprovider/features/addcategorypage/cubit/addcategory_cubit.dart';
import 'package:walaaprovider/features/addcategorypage/model/add_category_model.dart';
import 'package:walaaprovider/features/auth/login/presentation/screens/login.dart';
import 'package:walaaprovider/features/auth/register/presentation/screens/register.dart';
import 'package:walaaprovider/features/splash/presentation/screens/splash_screen.dart';

import '../cubit/profile_cubit.dart';
import '../widgets/profile_lsit_tail_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is OnUrlPayLoaded) {
              //  state.model.token=cubit.userModel!.data.token;
              Navigator.pushNamed(context, Routes.paymentRoute,
                      arguments: state.data.data!.payment_url)
                  .then((value) =>
                      {context.read<ProfileCubit>().onGetProfileData()});
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
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
                                height:
                                    MediaQuery.of(context).size.height / 3 - 60,
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
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          Routes.editprofileRoute,
                                        ),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.color1,
                                            borderRadius:
                                                BorderRadius.circular(22),
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
                                      'welcome'.tr() + " " + ('appname'.tr()),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    TextButton(
                                      onPressed: () {
                                        Preferences.instance.clearUserData();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 1300),
                                              child: LoginScreen(),
                                            ),
                                            ModalRoute.withName(
                                                Routes.initialRoute));
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
                                profileCubit.userModel!.user.balance
                                    .toString() +
                                "sr".tr(),
                            image: ImageAssets.walletIcon,
                            imageColor: AppColors.buttonBackground,
                            onclick: () async {
                              var resultLabel =
                                  await _showTextInputDialog(context);
                              if (resultLabel != null) {
                                print("D;dldlldl${resultLabel}");
                                profileCubit.onRechargeWallet(
                                    double.parse(resultLabel), context);
                              }
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
                            title: 'addcategory'.tr(),
                            image: ImageAssets.addIcon,
                            imageColor: AppColors.buttonBackground,
                            onclick: () {
                              context
                                  .read<AddcategoryCubit>()
                                  .controllerName_en
                                  .text = "";
                              context
                                  .read<AddcategoryCubit>()
                                  .controllerName_ar
                                  .text = '';
                              context.read<AddcategoryCubit>().imagePath = "";

                              //  widget.categoryModel = CategoryModel.name(0, '', '');
                              context
                                  .read<AddcategoryCubit>()
                                  .addCategoryModel = AddCategoryModel();
                              Navigator.pushNamed(
                                  context, Routes.addCategoryRoute,
                                  arguments: CategoryModel.name(0, '', ''));
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
                                  context, Routes.termsprivacyRoute,
                                  arguments: 'privacy');
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
                            onclick: () {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "\n" + "delete_account".tr(),
                                desc: "\n\n" +
                                    "waring_delete_account_message".tr() +
                                    "\n\n",
                                buttons: [
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    color: AppColors.color1,
                                    child: Text(
                                      "cancel".tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  DialogButton(
                                    onPressed: () =>
                                        profileCubit.deleteAccount(context),
                                    color: AppColors.error,
                                    child: Text(
                                      "confirm".tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                              ).show();
                            },
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () => {
                                            if (Platform.isIOS)
                                              {
                                                _openSocialUrl(
                                                    url:
                                                        "https://wa.me/+${profileCubit.settingModel.data.whatsapp}")
                                              }
                                            else
                                              {
                                                _openSocialUrl(
                                                    url:
                                                        "whatsapp://send?phone=/+${profileCubit.settingModel.data.whatsapp}")
                                              }
                                          },
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
                                      onTap: () => {
                                            _openSocialUrl(
                                                url: profileCubit.settingModel
                                                    .data.instagram)
                                          },
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
        ));
  }

  Future<String?> _showTextInputDialog(BuildContext context1) async {
    return showDialog(
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Text('addBalance'.tr()),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Balance'.tr()),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('addBalance'.tr()),
                onPressed: () =>
                    Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }

  void _openSocialUrl({required String url}) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          webViewConfiguration: const WebViewConfiguration(
              enableJavaScript: true, enableDomStorage: true));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'invalidUrl'.tr(),
          style: const TextStyle(fontSize: 18.0),
        ),
        backgroundColor: AppColors.primary,
        elevation: 8.0,
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
