import 'package:easy_localization/easy_localization.dart';
import 'package:phone_number/phone_number.dart';

class LoginModel {
  String phone = '';
  String password = '';
  String error_phone = '';
  String error_password = '';

  Future<bool> isDataValid() async {
    error_phone = '';
    error_password = '';
    bool vaild = false;
    if (phone.isNotEmpty) {
      vaild = await PhoneNumberUtil().validate(phone);
    }
    if (vaild && !password.isEmpty && password.length >= 6) {
      return true;
    } else {
      if (!vaild) {
        error_phone = 'invaild phone'.tr();
      }
      if (password.isEmpty) {
        error_password = 'incorrect pass';
      }
      return false;
    }
  }
}
