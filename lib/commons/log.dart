import 'dart:developer' as developer;

import 'package:getx_mvvm_boilerplate/commons/utils/string_utils.dart';

import '../application/env.dart';
import '../di/container.dart';

class AppLog {
  static const LOG_LEVEL_OFF = 0;
  static const LOG_LEVEL_V = 1;
  static const LOG_LEVEL_D = 2;
  static const LOG_LEVEL_I = 3;
  static const LOG_LEVEL_W = 4;
  static const LOG_LEVEL_E = 5;
  static final enable = false;

  static EnvironmentConfig _env() => inject<EnvironmentConfig>();

  static int get _level => _env().logLevel;

  static bool get _isSystemDebugging => _env().isSystemLogging;

  static bool get _isProduction => _env().isProduction;

  static void system(Object message) {
    if (!_isSystemDebugging) return;
    developer.log(message as String, name: 'SYSTEM', sequenceNumber: 1);
  }

  static void _log(
    Object? message, {
    String tag = 'LOG',
    int width = 100,
    int stackLevel = 1,
  }) {
    var s = StackTrace.current.toString().split('\n');
    var at = s[stackLevel].replaceFirst('#$stackLevel', '').trim();
    var ms = message.toString().chunk(width);
    var output = ms[0].padRight(width) + '--> at $at';
    output += ms
        .sublist(1)
        .map((m) => '\n' + m.padRight(width).padLeft(width + '[$tag] '.length))
        .join('');
    developer.log(output, name: tag);
  }

  static void v(
    Object message, {
    int width = 100,
    int stackLevel = 1,
  }) {
    if (_level > LOG_LEVEL_V) return;
    _log(message, width: width, stackLevel: stackLevel, tag: 'VERBOSE');
  }

  static void d(
    Object? message, {
    int width = 100,
    int stackLevel = 1,
  }) {
    if (_level > LOG_LEVEL_D) return;
    _log(message, width: width, stackLevel: stackLevel + 1, tag: 'DEBUG');
  }

  static void i(
    Object message, {
    int width = 100,
    int stackLevel = 1,
  }) {
    if (_level > LOG_LEVEL_I) return;
    developer.log(message as String, name: 'INFO');
  }

  static void w(
    Object message, {
    int width = 100,
    int stackLevel = 1,
  }) {
    if (_isProduction || _level > LOG_LEVEL_W) return;
    _log(message, width: width, stackLevel: stackLevel, tag: 'WARNING');
  }

  static void e(
    Object? message, {
    int width = 100,
    int stackLevel = 1,
  }) {
    if (_isProduction || _level > LOG_LEVEL_E) return;
    _log(message, width: width, stackLevel: stackLevel, tag: 'ERROR');
  }
}
