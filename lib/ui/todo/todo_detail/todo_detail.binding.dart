import 'package:get/get.dart';

import 'todo_detail.vm.dart';

class TodoDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoDetailVM>(() => TodoDetailVM());
  }
}
