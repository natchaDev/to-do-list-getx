import 'dart:io';

import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/constant.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/helpers/file_helper.dart';
import 'package:getx_mvvm_boilerplate/data/local_db/repositories/todo_repository.dart';
import 'package:getx_mvvm_boilerplate/models/rx_nullable.dart';
import 'package:getx_mvvm_boilerplate/models/todo_detail.dart';
import 'package:uuid/uuid.dart';

class CreateTodoVM extends BaseController {
  final Rx<String> selectedStatus = StatusType.inProgress.obs;
  final Rx<File?> image = RxNullable<File?>().setNull();
  final RxList<TodoDetail> todoDetailList = <TodoDetail>[].obs;
  final FileHelper _fileHelper = Get.find<FileHelper>();
  final TodoRepository _todoRepository = Get.find<TodoRepository>();

  onTakePhoto(File file) {
    image.value = file;
  }

  onSelectedStatus(String? status) {
    if (status == null) return;
    selectedStatus.value = status;
  }

  onSave({
    required String title,
    required DateTime date,
    String? description,
  }) {
    TodoDetail data = TodoDetail(
      const Uuid().v4(),
      title,
      DateTime.now().toUtc(),
      date.toUtc(),
      selectedStatus.value,
      description,
      _fileHelper.getImageBase64(image.value),
    );
    _todoRepository.put(todoDetail: data).then((_) {
      message.value = i18n.success;
    }).catchError((e) {
      showErrorMessage(e);
    });
  }
}
