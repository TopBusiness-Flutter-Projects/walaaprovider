
import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:walaaprovider/features/addcategorypage/cubit/addcategory_cubit.dart';
import 'package:walaaprovider/features/addproduct/presentation/cubit/add_product_cubit.dart';
import 'package:walaaprovider/features/auth/editprofile/presentation/cubit/edit_profile_cubit.dart';
import 'package:walaaprovider/features/auth/newpassword/cubit/new_password_cubit.dart';
import 'package:walaaprovider/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';
import 'package:walaaprovider/features/forgotpassword/cubit/forgot_password_cubit.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';
import 'package:walaaprovider/features/mainScreens/profilepage/presentation/cubit/profile_cubit.dart';
import 'package:walaaprovider/features/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import 'package:walaaprovider/features/payment_with_qr_page/presentation/cubit/payment_cubit.dart';
import 'package:walaaprovider/features/privacy_terms/presentation/cubit/settings_cubit.dart';
import 'package:walaaprovider/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:walaaprovider/injector.dart' as injector;

import 'core/utils/app_routes.dart';
import 'features/auth/login/presentation/cubit/Login_cubit.dart';
import 'features/mainScreens/cartPage/cubit/cart_cubit.dart';

class Cofee extends StatefulWidget {
  Cofee({Key? key}) : super(key: key);

  @override
  State<Cofee> createState() => _CofeeState();
}

class _CofeeState extends State<Cofee> {


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) =>
              injector.serviceLocator<SplashCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<NavigatorBottomCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<RegisterCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<VerficationCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<MenuCubit>(),
        )  ,
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<SettingsCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<AddcategoryCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<AddProductCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<CartCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<PaymentCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<OrderCubit>(),
        ) ,
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<EditProfileCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<ForgotPasswordCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<NewPasswordCubit>(),
        ),
      ],
      child:  GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: trans.tr('appname'),
        onGenerateRoute: AppRoutes.onGenerateRoute,

    ));
  }
}

