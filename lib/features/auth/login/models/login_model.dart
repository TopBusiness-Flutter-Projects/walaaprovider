import 'package:easy_localization/easy_localization.dart';
import 'package:phone_number/phone_number.dart';

class LoginModel {
  String phone = '';
  String phone_code='';
  String code='';
  String password = '';
  String error_phone = '';
  String error_password = '';

  Future<bool> isDataValid() async {
    error_phone = '';
    error_password = '';
    bool vaild = false;
    if (phone.isNotEmpty) {
      print("dddd${phone}");
      vaild = await PhoneNumberUtil().validate(phone_code+phone);
    }
    if (vaild && password.isNotEmpty && password.length >= 6) {
      return true;
    } else {
      if (!vaild) {
        error_phone = 'invaild phone'.tr();
      }
      if (password.isEmpty) {
        error_password = 'field_required'.tr();
      }
      else if (password.length<6) {
        error_password = 'invaild pass'.tr();
      }
      return false;
    }
  }
}
