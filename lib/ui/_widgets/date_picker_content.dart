import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/commons/validator.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

class DatePickerContent extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final List<FormFieldValidator<String>>? validatorList;
  final Function onTap;

  const DatePickerContent({
    Key? key,
    this.title,
    this.controller,
    this.validatorList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(context),
        VSpacings.xxSmall,
        _textField(context),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Row(
      children: [
        Text(
          (title ?? '').tr,
          style: context.textSmallBold,
        ),
        Text(
          ' *',
          style: context.textSmallBold.copyWith(
            color: ThemeData().alert(),
          ),
        ),
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeData().background2(),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () {
          onTap();
        },
        maxLines: 1,
        textInputAction: TextInputAction.go,
        validator: Validators.compose(validatorList ?? []),
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_month, color: ThemeData().icon(),),
          hintStyle: context.textMedium.copyWith(
            color: ThemeData().secondaryText(),
          ),
          hintText: i18n.pleaseSelect.tr,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
