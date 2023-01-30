import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/remote/service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.api) : super(SettingsInitial()){
    getSettings();
  }

  final ServiceApi api;

  late String privacyAr;
  late String privacyEn;
  late String termsAr;
  late String termsEn;

  getSettings() async {
    emit(SettingsLoading());
    final response =
     await api.getsetting();
    if(response.code==200){
      privacyEn = response.data.privacyEn;
      privacyAr = response.data.privacyAr;
      termsAr = response.data.termsAr;
      termsEn = response.data.termsEn;

      emit(SettingsLoaded());
    }
    else{
      emit(SettingsError());
    }

  }
}
