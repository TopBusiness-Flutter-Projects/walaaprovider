import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:walaaprovider/core/widgets/show_loading_indicator.dart';

import '../../../../core/utils/app_colors.dart';

import '../cubit/settings_cubit.dart';

class PrivacyAndTermsScreen extends StatelessWidget {
  PrivacyAndTermsScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  String text = 'NO Data';

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.only(right: 16, left: 16),
            icon: Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.primary,
              size: 35,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            'privacy'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.color1,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          SettingsCubit cubit = context.read<SettingsCubit>();
          if (state is SettingsLoading) {
            return ShowLoadingIndicator();
          }
          if (state is SettingsLoaded) {
            lang=='en'
                    ? text = cubit.privacyEn
                    : text = cubit.privacyAr;
          }
          return SingleChildScrollView(
            child: Column(
              children: [
               SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    text,
                    textStyle: TextStyle(color: AppColors.primary),
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
