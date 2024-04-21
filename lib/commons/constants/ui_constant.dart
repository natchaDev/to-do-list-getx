import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/ui/_theme/app_theme.dart';

class IconSize {
  static double get xxSmall => 10.0;

  static double get xSmall => 14.0;

  static double get small => 16.0;

  static double get medium => 18.0;

  static double get large => 24.0;

  static double get xlarge => 30.0;

  static double get xxLarge => 40.0;

  static double get xxxLarge => 64.0;
}

class Dimen {
  static double get xxxxxSmall => 4.0;

  static double get xxxxSmall => 6.0;

  static double get xxxSmall => 8.0;

  static double get xxSmall => 10.0;

  static double get xSmall => 12.0;

  static double get small => 14.0;

  static double get medium => 20.0;

  static double get large => 30.0;
}

class AppBorderShadow {
  static get shadow1 => BoxShadow(
        color: ThemeData().border(),
        spreadRadius: 2,
        blurRadius: 4,
      );
}

class AppDecoration {
  static BoxDecoration get card => BoxDecoration(
        color: ThemeData().background(),
        borderRadius: BorderRadius.circular(Dimen.xxxSmall),
        boxShadow: [
          AppBorderShadow.shadow1,
        ],
      );
}

class AppBorderRadius {
  static BorderRadius get zero => BorderRadius.circular(0.0);

  static BorderRadius get xxxSmall => BorderRadius.circular(Dimen.xxxSmall);

  static BorderRadius get xxSmall => BorderRadius.circular(Dimen.xxSmall);

  static BorderRadius get large => BorderRadius.circular(Dimen.large);
}

class VSpacings {
  static SizedBox get xxxxxSmall => SizedBox(height: Dimen.xxxxxSmall);

  static SizedBox get xxxxSmall => SizedBox(height: Dimen.xxxxSmall);

  static SizedBox get xxxSmall => SizedBox(height: Dimen.xxxSmall);

  static SizedBox get xxSmall => SizedBox(height: Dimen.xxSmall);

  static SizedBox get xSmall => SizedBox(height: Dimen.xSmall);

  static SizedBox get small => SizedBox(height: Dimen.small);

  static SizedBox get medium => SizedBox(height: Dimen.medium);

  static SizedBox get large => SizedBox(height: Dimen.large);
}

class HSpacings {
  static SizedBox get xxxxxSmall => SizedBox(width: Dimen.xxxxxSmall);

  static SizedBox get xxxxSmall => SizedBox(width: Dimen.xxxxSmall);

  static SizedBox get xxxSmall => SizedBox(width: Dimen.xxxSmall);

  static SizedBox get xxSmall => SizedBox(width: Dimen.xxSmall);

  static SizedBox get xSmall => SizedBox(width: Dimen.xSmall);

  static SizedBox get small => SizedBox(width: Dimen.small);

  static SizedBox get medium => SizedBox(width: Dimen.medium);

  static SizedBox get large => SizedBox(width: Dimen.large);
}
