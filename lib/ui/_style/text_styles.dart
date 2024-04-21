import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

extension TextStyles on BuildContext {
  double _getTextSize({
    required double textSize,
  }) {
    return isTablet ? textSize : textSize + 2;
  }

  TextStyle get _defaultText => TextStyle(
        color: ThemeData().primaryText(),
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,
        fontSize: _getTextSize(textSize: 14),
      );

  TextStyle get textExtraSmall => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 10),
        color: ThemeData().primaryText(),
      );

  TextStyle get textSmall => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 14),
        color: ThemeData().primaryText(),
      );

  TextStyle get textMedium => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 16),
        color: ThemeData().primaryText(),
      );

  TextStyle get textLarge => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 18),
        color: ThemeData().primaryText(),
      );

  TextStyle get textSmallNormal => textSmall.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(this).primaryText(),
      );

  TextStyle get textMediumNormal => textMedium.copyWith(
        fontWeight: FontWeight.w600,
      );

  TextStyle get textLargeNormal => textLarge.copyWith(
        fontWeight: FontWeight.w600,
      );

  TextStyle get textSmallBold => textSmall.copyWith(
        fontWeight: FontWeight.w800,
      );

  TextStyle get textMediumBold => textMedium.copyWith(
        fontWeight: FontWeight.w800,
      );

  TextStyle get textLargeBold => textLarge.copyWith(
        fontWeight: FontWeight.w800,
      );
}
