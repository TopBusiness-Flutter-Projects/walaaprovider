import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  List<OrderModel> orderList = [];
  late int odersize = 0;
  final ServiceApi serviceApi;

  late UserModel userModel;
  late String lang;

  OrderCubit(this.serviceApi) : super(OrderInitial()) {
    getUserData().then((value) => getorders(value));
  }

  setlang(String lang) {
    this.lang = lang;
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  getorders(UserModel? usermodel) async {
    odersize = 1;
    emit(AllOrderLoading());
    final response = await serviceApi.getOrders(usermodel!.access_token, lang);
    if (response.status.code == 200) {
      print(response.data);
      odersize=response.data.length;
      orderList = response.data!;
      emit(AllOrderLoaded(orderList));
    } else {
      print(response.status.message);
      emit(AllOrderError());
    }
  }
}
