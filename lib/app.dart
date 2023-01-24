
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/features/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import 'package:walaaprovider/injector.dart' as injector;

import 'core/utils/app_routes.dart';
import 'core/utils/app_strings.dart';
import 'features/auth/login/presentation/cubit/Login_cubit.dart';

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
              injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<NavigatorBottomCubit>(),
        ),
      ],
      child:  MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,

    ));
  }
}

