import 'dart:async';

// import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:makc/core/init/firebase_messaging_service.dart';
import 'package:makc/core/init/local_notifications_service.dart';
import 'package:makc/core/init/theme_controller.dart';
import 'package:makc/core/init/translation_service.dart';
import 'package:makc/data/controller/connection_controller.dart';
import 'package:makc/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

@immutable
final class ApplicationInitialize {
  const ApplicationInitialize._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {});
  }

  static Future<void> _initialize() async {
    try {
      // Core services - permanent
      await GetStorage.init();
      Get.put(TranslationService(), permanent: true);
      Get.put(ThemeController(), permanent: true);
      Get.put(ConnectionController(), permanent: true);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      final localNotificationsService = LocalNotificationsService.instance();
      await localNotificationsService.init();
      _initNetworkServices(localNotificationsService);
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  static Future<void> _initNetworkServices(LocalNotificationsService localNotificationsService) async {
    try {
      final firebaseMessagingService = FirebaseMessagingService.instance();
      await firebaseMessagingService.init(localNotificationsService: localNotificationsService);
      await FirebaseMessaging.instance.subscribeToTopic('EVENT');
    } catch (e) {
      debugPrint('Network service initialization failed (likely offline): $e');
    }
  }
}
