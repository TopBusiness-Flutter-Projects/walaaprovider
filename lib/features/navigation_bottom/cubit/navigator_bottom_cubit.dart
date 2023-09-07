import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';



part 'navigator_bottom_state.dart';

class NavigatorBottomCubit extends Cubit<NavigatorBottomState> {
  NavigatorBottomCubit(this.api) : super(NavigatorBottomInitial()){
    onUserDataSuccess();
    Preferences.instance.getUserModel().then((value) => {if(value.user.isLoggedIn!=false){
      getDeviceToken()
    }
    });
  }
  int page = 0;
  String title='home'.tr();
  //UserModel? user;
  String lan ='ff';
  String softwareType='';
  final ServiceApi api;

  getLan(context) {
    lan = EasyLocalization.of(context)!.locale.languageCode;
  }

  onUserDataSuccess() async {
 //   user = await Preferences.instance.getUserModel().whenComplete(() => null);
  }

  changePage(int index,String title) {
    page = index;
    this.title=title;
    emit(NavigatorBottomChangePage());
  }
  getDeviceToken()async{
    String? token=await FirebaseMessaging.instance.getToken();
    if(Platform.isAndroid){
      softwareType="android";
    }
    else {
      softwareType="ios";
    }
    final response=await api.addDeviceToken(token!, softwareType);

  }
}
