import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';

class AddProductModel {
  String image = '';

  String name_ar = '';
  String name_en = '';
  String price = '';
  int cat_id=0;
  String error_name_ar = '';
  String error_name_en = '';
  String error_price = '';

  bool isDataValid() {
    error_name_ar = '';
    error_name_en = '';
    error_price = '';
    //  print('data=>${projectName+"__"+details+"__"+feasibilityStudy+"__"+consultantTypes.length.toString()}');
    if (image.isNotEmpty && name_ar.isNotEmpty && name_en.isNotEmpty&&cat_id!=0&&price.isNotEmpty) {
      return true;
    } else {
      if (image.isEmpty) {
        toastMessage("Select Add Product image".tr(), AppColors.primary);
      }
      if (cat_id==0) {
        toastMessage("Select Category".tr(), AppColors.primary);
      }
      //print("object${name_en}");
      if (name_ar.isEmpty) {
        error_name_ar = "field_required".tr();
      }
      if (name_en.isEmpty) {
        error_name_en = "field_required".tr();
      }
      if(price.isEmpty){
        error_price = "field_required".tr();

      }
      return false;
    }
  }
}
