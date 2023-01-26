import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/firebase_options.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'package:walaaprovider/injector.dart' as injector;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await injector.setup();
  BlocOverrides.runZoned(
        () =>
        runApp(
          EasyLocalization(
            supportedLocales: const [Locale('ar', ''), Locale('en', '')],
            path: 'assets/lang',
            saveLocale: false,
            startLocale: const Locale('ar', ''),
            fallbackLocale: const Locale('ar', ''),
            child: Cofee(),
          ),
        ),
    blocObserver: AppBlocObserver(),
  );
}
