import 'package:getx_mvvm_boilerplate/application/path.dart';

import 'json_reader.dart';

class MockDataLoader {
  Future<Map<String, dynamic>?> load(String filename) async {
    var filePath = AppPath.mockData(filename);
    return JsonReader().readJsonFromFile<Map<String, dynamic>>(filePath);
  }

  Future<List<dynamic>?> loadArray(String filename) async {
    var filePath = AppPath.mockData(filename);
    return JsonReader().readJsonFromFile<List<dynamic>>(filePath);
  }
}
