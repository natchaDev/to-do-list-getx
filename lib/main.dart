import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getx_mvvm_boilerplate/di/config.dart';
import 'package:getx_mvvm_boilerplate/ui/main_application.dart';

import 'application/env.dart';
import 'di/container.dart';

void main() {
  var env = DevApiEnvironment();
  var container = DiContainer().withDefaultDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  runApp(MainApplication(
    env: env,
    container: container,
  ));
}
