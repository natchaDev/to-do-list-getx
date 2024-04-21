import 'dart:io';

import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/get_argument_constant.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/helpers/file_helper.dart';
import 'package:getx_mvvm_boilerplate/data/local_db/repositories/todo_repository.dart';
import 'package:getx_mvvm_boilerplate/models/rx_nullable.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:uuid/uuid.dart';

class TodoDetailVM extends BaseController {
  final Rx<String?> selectedStatus = RxNullable<String?>().setNull();
  final Rx<TodoDetail?> todoDetail = RxNullable<TodoDetail?>().setNull();
  final FileHelper _fileHelper = Get.find<FileHelper>();
  final TodoRepository _todoRepository = Get.find<TodoRepository>();
  final String _id = Get.arguments[GetArgumentConst.id] as String;

  @override
  void onInit() {
    _loadToDoDetail(_id);
    super.onInit();
  }

  _loadToDoDetail(String id) {
    _todoRepository.getTodoDetail(id).then((TodoDetail? data) {
      todoDetail.value = data;
      selectedStatus.value = data?.status;
    }).catchError((e) {
      showErrorMessage(e);
    });
  }

  onTakePhoto(File file) {
    todoDetail.value?.image = _fileHelper.getImageBase64(file);
    todoDetail.refresh();
  }

  onSelectedStatus(String? status) {
    if (status == null) return;
    selectedStatus.value = status;
    todoDetail.value?.status = status;
  }

  onSave({
    required String title,
    required DateTime dateTime,
    String? description,
  }) {
    if (todoDetail.value == null) return;
    TodoDetail data = TodoDetail(
      todoDetail.value!.id,
      title,
      DateTime.now().toUtc(),
      dateTime,
      todoDetail.value!.status,
      description,
      todoDetail.value!.image,
    );
    _todoRepository.put(todoDetail: data).then((_) {
      message.value = i18n.success;
    }).catchError((e) {
      showErrorMessage(e);
    });
  }
}
