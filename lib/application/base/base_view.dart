
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {

  Widget render(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  Widget showMessageDialog(String message) {
    return Container();
  }


  Widget loading() {
    return Container();
  }


}
