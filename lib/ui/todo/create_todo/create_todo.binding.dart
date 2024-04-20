import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/todo/create_todo/create_todo.vm.dart';

class CreateTodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTodoVM>(() => CreateTodoVM());
  }
}
