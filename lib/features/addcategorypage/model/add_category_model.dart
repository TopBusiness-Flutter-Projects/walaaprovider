import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';

class AddCategoryModel {
  String image = '';

  String name_ar = '';
  String name_en = '';
  String error_name_ar='';
  String error_name_en='';

  bool isDataValid() {
    error_name_ar='';
    error_name_en='';

    //  print('data=>${projectName+"__"+details+"__"+feasibilityStudy+"__"+consultantTypes.length.toString()}');
    if (image.isNotEmpty && name_ar.isNotEmpty&&name_en.isNotEmpty) {
      return true;
    } else {
      if (image.isEmpty) {
        toastMessage("Add Category image", AppColors.primary);
      }
      if (name_ar.isEmpty) {
        error_name_ar="field_required".tr();
      }
      if (name_en.isEmpty) {
        error_name_en="field_required".tr();
      }
      return false;
    }
  }
}
