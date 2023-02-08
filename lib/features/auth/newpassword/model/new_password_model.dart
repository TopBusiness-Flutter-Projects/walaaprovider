
class NewPasswordModel {
  String token = '';
  String password = '';
  String phone = '';

  String confirm_password = '';


  bool isDataValid() {
    if (
        password.isNotEmpty &&
        confirm_password.isNotEmpty &&
        confirm_password == password) {
      return true;
    }

    return false;
  }
}
