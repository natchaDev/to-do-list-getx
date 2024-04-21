import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.vm.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeVM>(() => HomeVM());
  }
}
