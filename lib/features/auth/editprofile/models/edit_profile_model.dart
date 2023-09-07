import 'package:easy_localization/easy_localization.dart';
import 'package:phone_number/phone_number.dart';

class EditProfileModel {
  String first_name = '';
  int role_id = 1;
  String location = '';
  String phone = '';
  String phone_code = '';
  String code = '';
  String password = '';
  String confirm_password = '';
  String image = '';
  String error_phone = '';
  String error_password = '';
  String error_confirm_password = '';
  String error_first_name = '';
  String error_location = '';
  bool vaild = false;

  Future<bool> isDataValid() async {
    error_phone = '';
    error_password = '';
    error_confirm_password = '';
    error_first_name = '';
    error_location = '';

    vaild = false;
    if (phone.isNotEmpty) {
      print("dddd${phone_code + phone}");
      vaild = await PhoneNumberUtil().validate(phone_code + phone);
      print("dddd${vaild}");
    }
    if (vaild &&
        (password.isEmpty ||
            (password.isNotEmpty &&
                password.length >= 6 &&
                password == confirm_password)) &&
        first_name.isNotEmpty &&
        location.isNotEmpty) {
      return true;
    } else {
      print("0e0e0488488484");
      print(phone_code + phone);

      if (!vaild) {
        error_phone = 'invaild phone'.tr();
      }
      if (password.isNotEmpty && password.length < 6) {
        error_password = 'invaild pass'.tr();
      }
      if (password != confirm_password) {
        error_confirm_password = 'pass_equal'.tr();
      }
      if (first_name.isEmpty) {
        error_first_name = 'field_required'.tr();
      }

      if (location.isEmpty) {
        print("dldldl${location}");

        error_location = 'field_required'.tr();
      }
      return false;
    }
  }
}
