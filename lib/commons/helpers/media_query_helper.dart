import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/commons/enum.dart';

class MediaQueryHelper {
  LayoutType? _layoutType;

  LayoutType? get layoutType => _layoutType;

  set setLayoutType(LayoutType layoutType) {
    _layoutType = layoutType;
  }

  initialLayoutType(BuildContext context) {
    setLayoutType = getLayoutType(context);
  }

  LayoutType getLayoutType(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 800) {
      return LayoutType.tabletLarge;
    } else if (MediaQuery.of(context).size.width > 600) {
      return LayoutType.tablet;
    } else {
      return LayoutType.mobile;
    }
  }
}
