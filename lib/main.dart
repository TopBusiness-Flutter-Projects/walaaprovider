import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:walaaprovider/firebase_options.dart';
import 'package:walaaprovider/features/mainScreens/orderpage/presentation/cubit/order_cubit.dart';


import 'app.dart';
import 'app_bloc_observer.dart';
import 'package:walaaprovider/injector.dart' as injector;

import 'features/navigation_bottom/cubit/navigator_bottom_cubit.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationDetails notificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
  ),
  iOS: DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  ),
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(message.data);
  showNotification(
      message.data['title'], message.data['body'], message.data['order_id']);
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await trans.EasyLocalization.ensureInitialized();
  await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('ic_launcher'),
        iOS: DarwinInitializationSettings(
            onDidReceiveLocalNotification: ondidnotification),
      ),
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification);
  await requestPermissions();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(
        message.data['title'], message.data['body'], message.data['order_id']);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(
        message.data['title'], message.data['body'], message.data['order_id']);
  });

  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE).then((value) {
  //
  //   print('************');
  //   print(value);
  //   print('************');
  //
  // });
  await injector.setup();
  BlocOverrides.runZoned(
    () => runApp(
      trans.EasyLocalization(
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

Future<void> requestPermissions() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

Future<void> showNotification(
    String title, String body, String order_id) async {
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
    payload: order_id,
  );
}

Future onSelectNotification(NotificationResponse details) async {
  print("object");
  print("object");
  Get.context!.read<OrderCubit>().getUserData().then((value) =>  Get.context!.read<OrderCubit>().getorders(value));
  Get.context!.
  read<NavigatorBottomCubit>().changePage(1, trans.tr('order'));
}

Future ondidnotification(
    int id, String? title, String? body, String? payload) async {
  print("object");
  Get.context!.read<OrderCubit>().getUserData().then((value) =>  Get.context!.read<OrderCubit>().getorders(value));

  Get.context!.
  read<NavigatorBottomCubit>().changePage(1, trans.tr('order'));
}
