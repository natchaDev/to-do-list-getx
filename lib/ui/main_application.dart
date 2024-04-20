import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/binding/initial_binding.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/languages.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

import '../application/env.dart';
import '../application/routes/app_pages.dart';

class MainApplication extends StatelessWidget {
  final EnvironmentConfig env;

  const MainApplication({
    Key? key,
    required this.env,
  }) : super(key: key);

  List<Locale> _getSupportedLocal() {
    return [
      const Locale('en', ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: env.getAppTitle(),
      initialBinding: InitialBinding(env),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      translations: Languages(),
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: _getSupportedLocal(),
    );
  }
}
