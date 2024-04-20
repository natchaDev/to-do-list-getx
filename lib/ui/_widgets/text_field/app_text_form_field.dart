import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/commons/validator.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

class AppTextFormField extends StatelessWidget with Validators {
  final TextEditingController controller;
  final String? title;
  final bool isRequired;
  final int maxLine;
  final List<FormFieldValidator<String>>? validatorList;

  AppTextFormField(
    this.controller, {
    this.title,
    this.isRequired = false,
    this.maxLine = 1,
    this.validatorList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleContent(context),
        TextFormField(
          controller: controller,
          maxLines: maxLine,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Validators.compose(validatorList ?? []),
        ),
      ],
    );
  }

  Widget _titleContent(BuildContext context) {
    return Row(
      children: [
        title != null
            ? Text(
                title?.tr ?? '',
                style: context.textSmallBold,
              )
            : Container(),
        isRequired
            ? Text(
                '*',
                style: context.textSmallBold.copyWith(
                  color: ThemeData().alert(),
                ),
              )
            : Container(),
      ],
    );
  }
}
