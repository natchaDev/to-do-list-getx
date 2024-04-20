import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/commons/constants/ui_constant.dart';
import 'package:getx_mvvm_boilerplate/ui/_style/text_styles.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

class MainAppBar {
  final BuildContext context;
  final String? title;
  final bool isRootPage;
  final double _toolBarHeight = 75;

  MainAppBar({
    required this.context,
    this.title,
    this.isRootPage = false,
  });

  AppBar get defaultAppbar => AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.grey.withOpacity(0.5),
        leading: _leading(isRootPage),
        title: _titleContent(title),
        toolbarHeight: _toolBarHeight,
        backgroundColor: ThemeData().background(),
      );

  Widget _leading(bool isRootPage) {
    return isRootPage
        ? Container()
        : IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ThemeData().icon(),
              size: IconSize.large,
            ),
            onPressed: () {
              Get.back();
            },
          );
  }

  Widget _titleContent(String? title) {
    if (title == null) return Container();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        title.tr,
        style: context.textLargeBold,
      ),
    );
  }
}
