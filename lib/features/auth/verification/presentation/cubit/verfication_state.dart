part of 'verfication_cubit.dart';

abstract class VerficationState {}

class VerficationInitial extends VerficationState {}



class SendCodeLoading extends VerficationState {}
class OnSmsCodeSent extends VerficationState {
  final String smsCode;

  OnSmsCodeSent(this.smsCode);
}
class CheckCodeInvalidCode extends VerficationState {}
class CheckCodeSuccessfully extends VerficationState {}
