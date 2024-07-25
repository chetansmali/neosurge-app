import 'package:amplitude_flutter/amplitude.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/local_notification_service.dart';
import 'data/models/user/assisted_service_user_details.dart';
import 'data/models/user/user.dart';
import 'di/get_it.dart';
import 'firebase_options.dart';
import 'logger.dart';
import 'presentation/cubits/bloc_observer.dart';

Future<void> configMain() async {
  configureDependencies();
  Logger().setLogLevel(LogLevel.debugFinest);
  Logger().setShowInReleaseMode(false);
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter('data');
  LocalNotificationService.initialize();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AssistedServiceUserDetailsAdapter());

  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //TODO : set to true in release
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
    kReleaseMode,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Setting amplitude
  if (kReleaseMode) {
    final Amplitude amplitude = Amplitude.getInstance();
    amplitude.init('b7d1beab01b6cb5152b2e6a556d3a066');
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print('A new onMessageOpenedApp event was published!');
    // print('message: ${message.data}');
    // print('message: ${message.notification?.body ?? ''}');
  });

  FirebaseMessaging.onMessage.first.then((RemoteMessage message) {
    // print('A new onMessage event was published!');
    // print('message: ${message.data}');
    // print('message: ${message.notification?.body ?? ''}');

    LocalNotificationService.displayNotification(message);
  });

  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      // print(message.notification!.title);
      // print(message.notification!.body);
    }
    LocalNotificationService.displayNotification(message);
  });

  return;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
  // print('message: ${message.data}');
  // print('message: ${message.notification?.body ?? ''}');
}
