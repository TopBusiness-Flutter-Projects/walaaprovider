
part of 'forgot_password_cubit.dart';



@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {


  ForgotPasswordInitial();
}



class OnForgotPasswordVaild extends ForgotPasswordState {
}

class OnForgotPasswordVaildFaild extends ForgotPasswordState {
}



class OnForgotPasswordSuccess extends ForgotPasswordState {
  UserModel user;

  OnForgotPasswordSuccess(this.user);
}

class OnError extends ForgotPasswordState {
  String error;
  OnError(this.error);
}





