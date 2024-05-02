import 'package:flutter/material.dart';

abstract class Palette extends ThemeExtension<Palette> {
  Color get selectedTimeChipColor;
  Color get selectedTabChipColor;
  Color get tabBackgroundColor;
  Color get selectedTabTextColor;
  Color get unselectedTabTextColor;
  Color get appBarTitleColor;
  Color get buyButtonColor;
  Color get sellButtonColor;
  Color get sellPriceColor;
  Color get selectedMenuItemBackgroundColor;
  Color get dropDownBackgroundColor;
  Color get bottomSheetBackgroundColor;
  Color get candleStickGainColor;
  Color get candleStickLossColor;
  Color get cardColor;
  Color? get tabBorderColor;
  String get logo;
  Color get filterLineColor;
  Color get popupMenuBackgroundColor;
  Color get popupMenuBorderColor;
  Color get modalBackgroundColor;
  Color get modalBorderColor;
  Color get textFieldBorderColor;
}
