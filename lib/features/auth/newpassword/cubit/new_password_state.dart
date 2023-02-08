
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
abstract class NewPasswordState {}

class NewPasswordInitial extends NewPasswordState {}




class UserDataValidation extends NewPasswordState {
  bool valid;

  UserDataValidation(this.valid);
}

class PasswordHidden extends NewPasswordState {
  bool valid;

  PasswordHidden(this.valid);
}



class IsLoading extends NewPasswordState {}

class OnNewPasswordSuccess extends NewPasswordState {

}


class OnError extends NewPasswordState {
  String error;
  OnError(this.error);
}