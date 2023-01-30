import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
   UserModel? userModel;

  ProfileCubit() : super(ProfileInitial()){
    getUserData();
  }

   getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    emit(ProfileGetUserModel());
  }

}
