import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/env.dart';
import 'package:getx_mvvm_boilerplate/commons/data/mock_data_loader.dart';
import 'package:getx_mvvm_boilerplate/commons/helpers/file_helper.dart';
import 'package:getx_mvvm_boilerplate/data/local_db/repositories/todo_repository.dart';
import 'package:getx_mvvm_boilerplate/data/network/repositories/api_repository.dart';
import 'package:getx_mvvm_boilerplate/data/network/services/api_service.dart';
import 'package:getx_mvvm_boilerplate/data/network/services/base_service/base_service.dart';
import 'package:getx_mvvm_boilerplate/data/preferences/user_preference.dart';

class InitialBinding implements Bindings {
  final EnvironmentConfig env;

  InitialBinding(this.env);

  @override
  void dependencies() {
    Get.put<Dio>(Dio());
    Get.put<MockDataLoader>(MockDataLoader());
    Get.put<UserPreference>(UserPreference());
    Get.put<BaseService>(BaseService(env));
    Get.put<ApiService>(ApiService());
    Get.put<ApiRepository>(ApiRepository());
    Get.put<TodoRepository>(TodoRepository());
    Get.put<FileHelper>(FileHelper());
  }
}
