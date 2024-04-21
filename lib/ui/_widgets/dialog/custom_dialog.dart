import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

extension CustomDialog on BuildContext {
  showMessageDialog({
    required String content,
    String? title,
    bool? isRequiredField,
    Function? onTap,
  }) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        elevation: 0.0,
        backgroundColor: ThemeData().background(),
        title: Text(
          (title ?? '').tr,
          textAlign: TextAlign.center,
          style: context.textLargeBold,
        ),
        content: Text(
          content.tr,
          style: context.textMedium,
        ),
        actions: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeData().alert(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onTap?.call();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 4),
                  Text(
                    i18n.close.tr,
                    style: context.textSmallBold.copyWith(
                      color: ThemeData().accent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> datePickerDialog() async {
    return await showDatePicker(
      context: this,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(5000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: const DatePickerThemeData(
              surfaceTintColor: Colors.transparent,
            ),
            colorScheme: ColorScheme.light(
              primary: ThemeData().primary(),
              onPrimary: ThemeData().accent(),
              onSurface: ThemeData().primary(),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ThemeData().primary(),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
