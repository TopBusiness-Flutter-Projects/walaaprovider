part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


class OnUrlPayLoaded extends ProfileState {
  final RechargeWalletModel data;
  OnUrlPayLoaded(this.data);
}
class OnDataLoaded extends ProfileState {
  final UserModel userModel;
  OnDataLoaded(this.userModel);
}
class SettingsLoaded extends ProfileState {
  final SettingModel settingModel;
  SettingsLoaded(this.settingModel);

}
class SettingsError extends ProfileState {}
