import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaaprovider/core/api/app_interceptors.dart';
import 'package:walaaprovider/features/addcategorypage/cubit/addcategory_cubit.dart';
import 'package:walaaprovider/features/addproduct/presentation/cubit/add_product_cubit.dart';
import 'package:walaaprovider/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';
import 'package:walaaprovider/features/mainScreens/homepage/cubit/home_cubit.dart';
import 'package:walaaprovider/features/mainScreens/menupage/cubit/menu_cubit.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';
import 'package:walaaprovider/features/mainScreens/profilepage/presentation/cubit/profile_cubit.dart';
import 'package:walaaprovider/features/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import 'package:walaaprovider/features/payment_screen/payment_page.dart';
import 'package:walaaprovider/features/payment_with_qr_page/presentation/cubit/payment_cubit.dart';
import 'package:walaaprovider/features/privacy_terms/presentation/cubit/settings_cubit.dart';
import 'package:walaaprovider/features/splash/presentation/cubit/splash_cubit.dart';

import 'core/remote/service.dart';
import 'features/auth/login/presentation/cubit/Login_cubit.dart';
import 'features/mainScreens/cartPage/cubit/cart_cubit.dart';

// import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  ///////////////////// Use Cases ////////////////////////
  //
  // serviceLocator.registerLazySingleton(
  //     () => GetSavedLanguageUseCase(languageRepository: serviceLocator()));
  //
  //////////////////////// Repositories ////////////////////////

  // serviceLocator.registerLazySingleton<BaseLanguageRepository>(
  //   () => LanguageRepository(
  //     languageLocaleDataSource: serviceLocator(),
  //   ),
  // );
  //
  //////////////////////// Data Sources ////////////////////////
  //
  // serviceLocator.registerLazySingleton<BaseLanguageLocaleDataSource>(
  //     () => LanguageLocaleDataSource(sharedPreferences: serviceLocator()));
  //
  //! Core
  //Network
  // serviceLocator.registerLazySingleton(() => NavigationService());
  // serviceLocator.registerLazySingleton<BaseNetworkInfo>(
  //     () => NetworkInfo(connectionChecker: serviceLocator()));

  // Api Consumer
  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));
  serviceLocator.registerFactory(
        () =>
        SplashCubit(

        ),
  );
  serviceLocator.registerFactory(
        () =>
        LoginCubit(
          serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
        () =>
        MenuCubit(
          serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
        () =>
        HomeCubit(
          serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
        () =>
        ProfileCubit(
            serviceLocator()
        ),
  );
  serviceLocator.registerFactory(
        () =>
        AddcategoryCubit(
            serviceLocator()

        ),
  );

  serviceLocator.registerFactory(
        () =>
        SettingsCubit(
            serviceLocator()

        ),
  );
  serviceLocator.registerFactory(
        () =>
        AddProductCubit(
            serviceLocator()

        ),
  );
  serviceLocator.registerFactory(
        () =>
            OrderCubit(
            serviceLocator()

        ),
  );
  serviceLocator.registerFactory(
        () =>
            PaymentCubit(
            serviceLocator()

        ),
  );

  serviceLocator.registerFactory(
        () =>
        RegisterCubit(
          serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
        () =>
        VerficationCubit(
          // serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(() => NavigatorBottomCubit());
  serviceLocator.registerFactory(() => CartCubit(serviceLocator()));
  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  // http
  // serviceLocator.registerLazySingleton(() => http.Client());

  // Dio
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  serviceLocator.registerLazySingleton(
        () =>
        Dio(
          BaseOptions(
            contentType: "application/x-www-form-urlencoded",
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          ),
        ),
  );
  // serviceLocator.registerLazySingleton(() => AppInterceptors());
  serviceLocator.registerLazySingleton(
        () =>
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          error: true,
        ),
  );

  // Internet Connection Checker
  // serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
