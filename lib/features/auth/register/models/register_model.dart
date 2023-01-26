import 'package:easy_localization/easy_localization.dart';
import 'package:phone_number/phone_number.dart';

class RegisterModel {
  String first_name = '';
  String last_name = '';
  int role_id = 1;
  String location = '';
  String phone = '';
  String phone_code = '';
  String code = '';
  String password = '';
  String confirm_password = '';
  String error_phone = '';
  String error_password = '';
  String error_confirm_password = '';
  String error_first_name = '';
  String error_last_name = '';
  String error_location = '';
  Future<bool> isDataValid() async {
    error_phone = '';
    error_password = '';
    error_confirm_password = '';
    error_first_name = '';
    error_last_name = '';
    error_location = '';

    bool vaild = false;
    if (phone.isNotEmpty) {
      print("dddd${phone}");
      vaild = await PhoneNumberUtil().validate(phone_code + phone);
    }
    if (vaild && password.isNotEmpty && password.length >= 6&&password==confirm_password&&first_name.isNotEmpty&&last_name.isNotEmpty&&location.isNotEmpty) {
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
      if (confirm_password.isEmpty) {
        error_confirm_password = 'field_required'.tr();
      }
      else if (password!=confirm_password) {
        error_confirm_password = 'pass_equal'.tr();
      }
      if(first_name.isEmpty){
        error_first_name='field_required'.tr();
      }
      if(last_name.isEmpty){
        error_last_name='field_required'.tr();
      }
      if(location.isEmpty){
        print("dldldl${location}");

        error_location='field_required'.tr();
      }
      return false;
    }
  }
}
