import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/core/models/user_model.dart';
import 'package:walaaprovider/core/preferences/preferences.dart';
import 'package:walaaprovider/core/remote/handle_exeption.dart';
import 'package:walaaprovider/core/remote/service.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/appwidget.dart';
import 'package:walaaprovider/core/utils/toast_message_method.dart';
import 'package:walaaprovider/features/addproduct/presentation/model/add_product_model.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  XFile? imageFile;
  String imagePath = '';
  AddProductModel addProductModel = AddProductModel();
  UserModel? userModel;
  bool isValid = false;
  List<CategoryModel> categoryList = [];

  TextEditingController controllerName_ar = TextEditingController();
  TextEditingController controllerName_en = TextEditingController();
  TextEditingController controllerprice= TextEditingController();
  final ServiceApi serviceApi;
  String? message;
  String? lang;

  AddProductCubit(this.serviceApi) : super(AddProductInitial()) {
    getUserData();
    checkValidData();
  }

  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    emit(OnUserDataVaild());
  }
  setlang(String lang) {
    this.lang = lang;
  }
  getSingleProduct(int cat_id, BuildContext context, String token) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    print("Dlddkk${cat_id}");

    try {
      final response = await serviceApi.getsingleProduct(cat_id,token);
      print("Dlddkk${response.data.name_en}");
      if (response.status.code == 200) {
        Navigator.pop(context);

        emit(OnProductLoaded(response.data));
      } else {
        Navigator.pop(context);
        emit(OnProductError());
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(OnAddProductError());
      throw errorMessage;
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
    addProductModel.image = imagePath;

    emit(AddProductPickImageSuccess());
    checkValidData();
  }

  Future<void> checkValidData() async {
    bool vaild = await addProductModel.isDataValid();
    if (vaild) {
      isValid = true;
      emit(OnAddProductVaild());
    } else {
      isValid = false;

      emit(OnAddProductVaildFaild());
    }
  }

  addProduct(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      final response = await serviceApi.addProduct(
          addProductModel, userModel!.access_token);

      if (response.code == 200) {
        Navigator.pop(context);
        addProductModel.name_en = '';
        addProductModel.name_ar = '';
        addProductModel.image = '';
        imagePath = '';
        controllerName_ar.text='';
        controllerName_en.text='';
        controllerprice.text='';
        context.read<MenuCubit>().setlang(lang!);
        context.read<MenuCubit>().getcategory(userModel);
        context.read<HomeCubit>().getcategory(userModel);
        toastMessage("sucess", AppColors.primary);
        addProductModel.cat_id=0;
        Future.delayed(Duration(milliseconds: 400), () {
          Navigator.pop(context);
        });
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(OnAddProductError());
      throw errorMessage;
    }
  }
  editProduct(BuildContext context,int product_id) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());

    try {
      final response = await serviceApi.editProduct(
          addProductModel, userModel!.access_token,product_id);

      if (response.code == 200) {
        Navigator.pop(context);
        addProductModel.name_en = '';
        addProductModel.name_ar = '';
        addProductModel.image = '';
        controllerName_ar.text='';
        controllerName_en.text='';
        controllerprice.text='';

        imagePath = '';
        context.read<MenuCubit>().setlang(lang!);
        context.read<MenuCubit>().getProduct(userModel,addProductModel.cat_id);
        context.read<HomeCubit>().getProduct(userModel,addProductModel.cat_id);
        toastMessage("sucess", AppColors.primary);
        addProductModel.cat_id=0;
        Future.delayed(Duration(milliseconds: 400), () {
          Navigator.pop(context);
        });
      }
    } on DioError catch (e) {
      Navigator.pop(context);
      print(" Error : ${e}");
      final errorMessage = DioExceptions.fromDioError(e).toString();
      emit(OnAddProductError());
      throw errorMessage;
    }
  }
  getcategory(UserModel? usermodel) async {

    final response =
    await serviceApi.getCategory(usermodel!.access_token, lang!);
    if (response.status.code == 200) {
      print(response.data);

      categoryList = response.data!;
      emit(AllCategoryLoaded(categoryList));

    }else {
      print(response.status.message);
      emit(AllCategoryError());
    }
  }
}
