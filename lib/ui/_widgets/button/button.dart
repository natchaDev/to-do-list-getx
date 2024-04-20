import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? textColor;
  final bool isEnable;
  final bool isExpandTitle;
  final TextStyle? fontSize;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.borderColor,
    this.textColor,
    this.isEnable = true,
    this.isExpandTitle = false,
    this.fontSize,
  });

  Widget _titleContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: Text(
        title.tr,
        style: fontSize ??
            context.textSmall
                .copyWith(color: textColor ?? ThemeData().primary()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? ThemeData().primary()),
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ThemeData().background(),
        ),
        onPressed: isEnable ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? Container(),
            isExpandTitle
                ? Expanded(child: _titleContent(context))
                : _titleContent(context),
          ],
        ),
      ),
    );
  }
}
