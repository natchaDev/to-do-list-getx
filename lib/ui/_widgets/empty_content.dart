import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        'empty'.tr,
        // style: Styles(uiTheme)
        //     .textMedium
        //     .copyWith(color: uiTheme.secondaryTextColor),
      ),
    );
  }
}
