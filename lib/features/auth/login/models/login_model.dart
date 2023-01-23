import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';

class LoginModel {
  String email = '';
  String password = '';
  String error_email='';
  String error_password='';

  bool isDataValid() {
    error_email='';
   error_password='';
    if (EmailValidator.validate(email) &&
        !password.isEmpty &&
        password.length >= 6) {
      return true;
    }
    else {
      if (!EmailValidator.validate(email)){
      error_email='invaild email';
      }
      if(password.isEmpty) {
        error_password = 'incorrect pass';
      }
        return false;
    }



  }
}
