import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

class AddButton extends StatelessWidget {
  final Function() onTap;
  final double width;
  final double height;

  const AddButton({
    super.key,
    required this.onTap,
    this.width = 54,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: ThemeData().primary(),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 54,
        height: 54,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: IconSize.large,
        ),
      ),
      onTap: () {
        onTap.call();
      },
    );
  }
}
