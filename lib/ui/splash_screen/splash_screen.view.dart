import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/commons/enum.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.binding.dart';
import 'package:getx_mvvm_boilerplate/ui/home/home.view.dart';
import 'package:getx_mvvm_boilerplate/ui/splash_screen/splash_screen.vm.dart';

import '../../application/base/base_view.dart';
import '../_style/text_styles.dart';

class SplashScreenView extends BaseView<SplashScreenController> {
  @override
  Widget render(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData().scaffoldBackground(),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('test', style: context.textLargeBold),
                InkWell(
                  child: const Text(
                    'go to home',
                  ),
                  onTap: () {
                    Get.to(
                      () => HomeView(),
                      binding: HomeBinding(),
                    );
                  },
                )
              ],
            ),
          ),
          Obx(
            () => controller.pageState == PageState.LOADING
                ? loading()
                : Container(),
          ),
        ],
      ),
    );
  }
}
