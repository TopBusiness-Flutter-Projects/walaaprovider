import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/features/addcategorypage/model/add_category_model.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';

part 'addcategory_state.dart';

class AddcategoryCubit extends Cubit<AddcategoryState> {
  XFile? imageFile;
  String imagePath = '';
  AddCategoryModel addCategoryModel = AddCategoryModel();
  UserModel? userModel;
  bool isValid = false;

  final ServiceApi serviceApi;

  String? message;

  AddcategoryCubit(this.serviceApi) : super(AddcategoryInitial()) {
    getUserData();
    checkValidData();
  }

  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
  }
  getSingleCategory(int cat_id,BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    final response =
    await serviceApi.getsingleCategory(cat_id);
    if(response.status.code==200){
Navigator.pop(context);

      emit(OncategoryLoaded(response.data));
    }
    else{
      emit(OncategoryError());
    }

  }

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
    addCategoryModel.image = imagePath;

    emit(AddcategoryPickImageSuccess());
    checkValidData();
  }

  Future<void> checkValidData() async {
    bool vaild = await addCategoryModel.isDataValid();
    if (vaild) {
      isValid = true;
      emit(OnAddcategoryVaild());
    } else {
      isValid = false;

      emit(OnAddcategoryVaildFaild());
    }
  }

  addcategory(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    try {
      final response = await serviceApi.addCategory(
          addCategoryModel, userModel!.access_token);

      if (response.code == 200) {
        Navigator.pop(context);
        addCategoryModel.name_en = '';
        addCategoryModel.name_ar = '';
        addCategoryModel.image = '';
        imagePath='';
        context.read<MenuCubit>().setlang(lang);
        context.read<MenuCubit>().getcategory(userModel);
        context.read<HomeCubit>().getcategory(userModel);
        toastMessage("sucess", AppColors.primary);

        Future.delayed(Duration(milliseconds: 400), () {

          Navigator.pop(context);
        });
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(OnAddcategoryError());
      throw errorMessage;
    }
  }
}
