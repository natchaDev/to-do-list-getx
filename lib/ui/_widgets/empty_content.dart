import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/assets/i18n/i18n_constant.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';

class EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        i18n.empty.tr,
        style: context.textSmall,
      ),
    );
  }
}
