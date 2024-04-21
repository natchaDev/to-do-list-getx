import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:getx_mvvm_boilerplate/application/life_cycle_linstener.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> implements LifeCycleListener {
  final _ContextHolder _contextHolder = _ContextHolder();

  BuildContext? get context => _contextHolder.context;

  bool _isInitial = false;

  bool get isInitial => _isInitial;

  @override
  void onInit() {}

  @override
  void onBuild() {}

  @override
  void onDispose() {}

  @override
  void onResume() {}

  @override
  void onPause() {}

  @override
  void onInactive() {}

  @override
  void onDetach() {}

  Widget render(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _contextHolder.context = context;
    Future.delayed(const Duration(seconds: 0), () {
      if (!_isInitial) {
        onInit();
        _isInitial = true;
      }
    });
    return render(context);
  }

  Widget baseContent({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(Dimen.medium),
      child: child,
    );
  }

  Widget loading() {
    return Container();
  }
}

class _ContextHolder {
  BuildContext? context;
}
