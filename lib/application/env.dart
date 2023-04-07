import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import '../commons/log.dart';

@immutable
abstract class EnvironmentConfig extends InheritedWidget {
  EnvironmentConfig({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final int logLevel = AppLog.LOG_LEVEL_OFF;
  final bool isDebugMode = false;

  bool get isProduction {
    return !isDebug;
  }

  bool get isDebug {
    return isDebugMode;
  }

  final bool isUsingMockApiData = false;

  final bool isLogging = false;

  final bool isSystemLogging = false;

  String getServerType();

  String getServiceApiBaseUrl();

  String getAppTitle();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static EnvironmentConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EnvironmentConfig>();
  }
}

class DemoApiEnvironment extends EnvironmentConfig {
  @override
  final int logLevel = AppLog.LOG_LEVEL_D;

  @override
  final bool isDebugMode = true;

  @override
  final bool isUsingMockApiData = false;

  DemoApiEnvironment() : super(child: Container());

  @override
  String getServerType() => ServerType.demo;

  @override
  String getServiceApiBaseUrl() => '';

  @override
  String getAppTitle() => 'Demo';
}

class DevApiEnvironment extends EnvironmentConfig {
  @override
  final int logLevel = AppLog.LOG_LEVEL_D;

  @override
  final bool isDebugMode = true;

  @override
  final bool isUsingMockApiData = false;

  DevApiEnvironment() : super(child: Container());

  @override
  String getServerType() => ServerType.dev;

  @override
  String getServiceApiBaseUrl() => '';

  @override
  String getAppTitle() => 'Dev api';
}

class DevLocalEnvironment extends EnvironmentConfig {
  @override
  final int logLevel = AppLog.LOG_LEVEL_D;

  @override
  final bool isDebugMode = true;

  @override
  final bool isUsingMockApiData = false;

  DevLocalEnvironment() : super(child: Container());

  @override
  String getServerType() => ServerType.devLocal;

  @override
  String getServiceApiBaseUrl() {
    final String localHost = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    return 'http://$localHost:8000/api';
  }

  @override
  String getAppTitle() => 'SiteAround';
}

class ProductionEnvironment extends EnvironmentConfig {
  @override
  final int logLevel = AppLog.LOG_LEVEL_W;

  @override
  final bool isDebugMode = false;

  @override
  final bool isUsingMockApiData = false;

  ProductionEnvironment() : super(child: Container());

  @override
  String getServerType() => ServerType.production;

  @override
  String getServiceApiBaseUrl() => '';

  @override
  String getAppTitle() => 'Prod';
}
