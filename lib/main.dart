import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:walaaprovider/firebase_options.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'package:walaaprovider/injector.dart' as injector;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: IOSInitializationSettings(),
    ),
  );
  await requestPermissions();
  NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );
  Future<void> showNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'payload',
    );
  }
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print(message);
    showNotification(message.data['title'], message.data['body']);

  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body']);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body']);

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
  );}
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
    );}

