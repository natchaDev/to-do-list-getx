import 'dart:convert';
import 'dart:io';
import 'package:getx_mvvm_boilerplate/commons/constants/table_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/utils/list_utils.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class TodoRepository {
  put({required TodoDetail todoDetail}) async {
    await _put(
      box: await _initBox(BoxName.todo),
      key: todoDetail.id.toString(),
      json: jsonEncode(todoDetail.toJson()),
    );
  }

  Future<List<TodoDetail>> getTodoDetailList() async {
    LazyBox box = await _initBox(BoxName.todo);
    var list = box.keys.toList();
    if (list.isBlank) return [];
    return await Future.wait(list.map((dynamic item) async {
      var data = await box.get(item);
      Map<String, dynamic> decode = jsonDecode(data);
      return TodoDetail.fromJson(decode);
    }).toList());
  }

  Future<TodoDetail?> getTodoDetail(String id) async {
    var box = await _initBox(BoxName.todo);
    var data = await box.get(id);
    if (data == null) return null;
    return TodoDetail.fromJson(jsonDecode(data));
  }

  Future<LazyBox> _initBox(String name) async {
    Directory directory = await getTemporaryDirectory();
    Hive.init(directory.path);
    return Hive.isBoxOpen(name)
        ? Hive.lazyBox(name)
        : await Hive.openLazyBox(name);
  }

  Future<void> _put({
    required LazyBox box,
    required String key,
    required dynamic json,
  }) async {
    if (box.containsKey(key)) {
      await box.delete(key);
      await box.compact();
    }
    await box.put(key, json);
  }

  Future<void> deleteByKey({required String key, required String boxName}) async {
    var box = await _initBox(boxName);
    await box.delete(key);
  }

  deleteAll() async {
    Directory directory = await getTemporaryDirectory();
    Hive.init(directory.path);
    await Hive.deleteFromDisk();
  }
}
