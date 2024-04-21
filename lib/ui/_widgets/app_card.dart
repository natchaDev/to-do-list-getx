import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  AppCard({
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.card,
      child: Container(
        padding: padding ?? const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
