import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_theme/color_theme_dark.dart';
import 'color_theme/color_theme_light.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData().background(),
      iconTheme: IconThemeData(color: ThemeData().icon()),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData().background(),
      iconTheme: IconThemeData(color: ThemeData().icon()),
    ),
  );
}

extension AppThemeExt on ThemeData {
  Color primary() {
    return Get.isDarkMode
        ? ColorThemeDark().primaryColor
        : ColorThemeLight().primaryColor;
  }

  Color secondary() {
    return Get.isDarkMode
        ? ColorThemeDark().secondaryColor
        : ColorThemeLight().secondaryColor;
  }

  Color accent() {
    return Get.isDarkMode
        ? ColorThemeDark().accentColor
        : ColorThemeLight().accentColor;
  }

  Color primaryText() {
    return Get.isDarkMode
        ? ColorThemeDark().primaryTextColor
        : ColorThemeLight().primaryTextColor;
  }

  Color secondaryText() {
    return Get.isDarkMode
        ? ColorThemeDark().secondaryTextColor
        : ColorThemeLight().secondaryTextColor;
  }

  Color scaffoldBackground() {
    return Get.isDarkMode
        ? ColorThemeDark().scaffoldBackgroundColor
        : ColorThemeLight().scaffoldBackgroundColor;
  }

  Color background() {
    return Get.isDarkMode
        ? ColorThemeDark().backgroundColor
        : ColorThemeLight().backgroundColor;
  }

  Color background2() {
    return Get.isDarkMode
        ? ColorThemeDark().background2Color
        : ColorThemeLight().background2Color;
  }

  Color icon() {
    return Get.isDarkMode
        ? ColorThemeDark().iconColor
        : ColorThemeLight().iconColor;
  }

  Color border() {
    return Get.isDarkMode
        ? ColorThemeDark().borderColor
        : ColorThemeLight().borderColor;
  }

  Color alert() {
    return Get.isDarkMode
        ? ColorThemeDark().alertColor
        : ColorThemeLight().alertColor;
  }
}
