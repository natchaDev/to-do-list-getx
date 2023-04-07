import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

import '../../commons/color_adapter.dart';
import '../../commons/enum.dart';
import '../../commons/helpers/media_query_helper.dart';
import '../../di/container.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  static double _getTextSize({
    required double textSize,
  }) {
    MediaQueryHelper mediaQueryHelper = inject<MediaQueryHelper>();
    return mediaQueryHelper.layoutType == LayoutType.tablet
        ? textSize + 2
        : textSize;
  }

  static final TextStyle _defaultText = TextStyle(
    color: HexColor.fromHex('#8F8F8F'),
    fontFamily: 'Lato',
    fontWeight: FontWeight.w400,
    fontSize: _getTextSize(textSize: 14),
  );

  TextStyle get textExtraSmall => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 10),
        color: Theme.of(context).primaryText(),
      );

  TextStyle get textSmall => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 14),
        color: Theme.of(context).primaryText(),
      );

  TextStyle get textMedium => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 16),
        color: Theme.of(context).primaryText(),
      );

  TextStyle get textLarge => _defaultText.copyWith(
        fontSize: _getTextSize(textSize: 18),
        color: Theme.of(context).primaryText(),
      );

  TextStyle get textSmallNormal => textSmall.copyWith(
        fontWeight: FontWeight.w600,
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
