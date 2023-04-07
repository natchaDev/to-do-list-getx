import 'package:get/get.dart';

import '../../application/base/base_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
  }
}

class SplashScreenController extends BaseController {
  @override
  void onInit() {
    // TODO: implement onInit

    print('test');
  }
}
