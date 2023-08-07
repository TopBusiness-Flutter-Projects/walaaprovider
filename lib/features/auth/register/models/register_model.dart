import 'package:easy_localization/easy_localization.dart';
import 'package:phone_number/phone_number.dart';

class RegisterModel {
  String name = '';
  int role_id = 1;
  int provider_id=2;
  String location = '';
  String phone = '';
  String phone_code = '';
  String code = '';
  String password = '';
  String confirm_password = '';
  String error_phone = '';
  String error_password = '';
  String error_confirm_password = '';
  String error_name = '';
  String error_last_name = '';
  String error_location = '';
  Future<bool> isDataValid() async {
    error_phone = '';
    error_password = '';
    error_confirm_password = '';
    error_name = '';
    error_location = '';

    bool vaild = true;
    print(name.split(" ").length.toString());
    if (phone.isNotEmpty) {
      print("dddd${phone}");
   //   vaild = await PhoneNumberUtil().validate(phone_code + phone);
    }
    if (vaild && password.isNotEmpty && password.length >= 6&&password==confirm_password&&name.isNotEmpty&&(name.split(" ").length==2&&name.split(" ")[1].length>0)&&location.isNotEmpty) {
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
      if(name.isEmpty){
        error_name='field_required'.tr();
      }
      else if(name.split(" ").length!=2||name.split(" ")[1].length==0){
        error_name='must_two_name'.tr();

      }
     
      if(location.isEmpty){
        print("dldldl${location}");

        error_location='field_required'.tr();
      }
      return false;
    }
  }
}
