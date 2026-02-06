import 'dart:io';

// Core
import 'package:makc/core/init/app_initialize.dart';
import 'package:makc/core/init/theme_controller.dart';
import 'package:makc/core/init/translation_service.dart';
import 'package:makc/core/theme/custom_dark_theme.dart';
import 'package:makc/core/theme/custom_light_theme.dart';
import 'package:makc/core/widgets/common/global_safe_are.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:makc/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:makc/modules/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationInitialize.initialize();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _storage = GetStorage();

  String _getLanguageCode(String languageName) {
    switch (languageName) {
      case 'English':
        return 'en';
      case 'Русский':
        return 'ru';
      case 'Türkmençe':
      default:
        return 'tr';
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = _storage.read('selectedLanguage') ?? 'Türkmençe';
    final languageCode = _getLanguageCode(selectedLanguage);

    return GetMaterialApp(
      translations: TranslationService(),
      locale: Locale(languageCode),
      fallbackLocale: const Locale('tr', 'TR'),
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      themeMode: Get.find<ThemeController>().themeMode,
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      initialBinding: DashboardBinding(),
      builder: (context, child) {
        return GlobalSafeAreaWrapper(
          top: false,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const SplashPage(),
    );
  }
}
