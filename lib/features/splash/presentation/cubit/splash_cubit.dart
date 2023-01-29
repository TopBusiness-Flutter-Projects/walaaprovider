import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()){
   onUserFirst();
  }

  onUserDataSuccess() async {
    UserModel model = await Preferences.instance.getUserModel();
    if(model.user.isLoggedIn){
      emit(OnUserModelGet(model));
    }else{
      emit(NoUserFound());
    }
  }
  onUserFirst() async {
    String?  first = await Preferences.instance.getFirstInstall();
    if(first!= null){
      onUserDataSuccess();
    }else{
      emit(UserFrst());
    }
  }
}
