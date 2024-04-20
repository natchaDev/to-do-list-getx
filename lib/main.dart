import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/main_application.dart';

import 'application/env.dart';

void main() {
  DevLocalEnvironment env = Get.put(DevLocalEnvironment());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  runApp(MainApplication(
    env: env,
  ));
}
