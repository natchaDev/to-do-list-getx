import 'dart:convert';
import 'package:flutter/services.dart' show ByteData, CachingAssetBundle, rootBundle;
import 'package:flutter/widgets.dart';

class JsonReader {
  Future<T?> readJsonFromFile<T>(String filePath) async {
    final content = await MyAssetBundle().loadString(filePath);
    var m = json.decode(content);
    return m;
  }
}

/*
 * !!! WARNING !!!
 * because rootBundle.loadString() detect if file size >= 10kb
 * it will loaded with isolate
 * that cause in test mode, the test will finish before assets are loaded
 * we will receive empty assets by randomly
 */
class MyAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final ByteData data = await load(key);
    if (data == null) throw FlutterError('Unable to load asset');
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
