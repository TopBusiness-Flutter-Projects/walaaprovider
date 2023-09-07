import 'package:country_codes/country_codes.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/features/auth/editprofile/models/edit_profile_model.dart';
import 'package:walaaprovider/features/mainScreens/profilepage/presentation/cubit/profile_cubit.dart';

import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileModel editProfileModel = EditProfileModel();
  bool isEditProfileValid = false;
  XFile? imageFile;
  String imagePath = '';
  String? message;
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerPhoneCode = TextEditingController();
  TextEditingController controllerlocation = TextEditingController();

  late UserModel userModel;

  EditProfileCubit(this.serviceApi) : super(EditProfileInitial()) {

    checkValidEditProfileData();
    getUserData().then((value) => updateData(value));
  }

  final ServiceApi serviceApi;

/////////////// Methods /////////////////

//////////////////////////////////////
  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    imagePath = croppedFile!.path;
    editProfileModel.image = imagePath;

    emit(AddProfilePickImageSuccess());
    checkValidEditProfileData();
  }

  Future<UserModel?> getUserData() async {
    await CountryCodes.init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  userEditProfile(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      final response = await serviceApi.userEditProfile(editProfileModel,userModel.access_token);
print("ddddd")
;
print(response);
if (response.status.code == 200) {
        Navigator.pop(context);
        response.userModel.access_token=userModel.access_token;
        Preferences.instance.setUser(response.userModel).then((value) =>{
        context.read<ProfileCubit>().getUserData(),
            Navigator.pop(context)}
        );




      }

      else if (response.status.code == 409) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "invaild phone".tr(), // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
            timeInSecForIosWeb: 1 // duration
            );
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(EditProfileError());
      throw errorMessage;
    }
  }

  Future<void> checkValidEditProfileData() async {
    bool vaild = await editProfileModel.isDataValid();
    if (vaild) {
      isEditProfileValid = true;
      print("object${isEditProfileValid}");
      emit(OnEditProfileVaild());
    } else {
      isEditProfileValid = false;

      emit(OnEditProfileVaildFaild());
    }
    print("obtyyryyryject${isEditProfileValid}");
  }

  updateData(UserModel? value) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(value!.user.phone_code+value.user.phone);
print("objectssss");
print(number.isoCode);
    editProfileModel
      ..image=value.user.image
      ..first_name=value.user.name
      ..location=value.user.location
      ..phone=value.user.phone
      ..phone_code=value.user.phone_code
      ..code=number.isoCode!
    ;


    controllerFirstName.text = value.user.name;
    controllerLastName.text = value.user.name;
    controllerlocation.text = value.user.location;
    controllerPhone.text = value.user.phone;

//    print("ddd${editProfileModel.phone}");
  //  print("ddd${number.isoCode}");
    checkValidEditProfileData();

  }
}
