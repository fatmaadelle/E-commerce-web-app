import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// todo configure text family and size
class MyFonts
{
  // return the right font depending on app language
  static TextStyle get getAppFontType => const TextStyle(fontFamily: 'Poppins');

  // headlines text font
  static TextStyle get headlineTextStyle => getAppFontType;

  // body text font
  static TextStyle get bodyTextStyle => getAppFontType;

  // button text font
  static TextStyle get buttonTextStyle => getAppFontType;

  // app bar text font
  static TextStyle get appBarTextStyle  => getAppFontType;

  // chips text font
  static TextStyle get chipTextStyle  => getAppFontType;

  // appbar font size
  static double get appBarTittleSize => 10.sp;

  // headlines text font
  static TextStyle get displayTextStyle => getAppFontType;

  // body font size
  static double get bodySmallTextSize => 10.sp;
  static double get bodyMediumSize => 10.sp; // default font
  static double get bodyLargeSize => 10.sp;
  // display font size
  static double get displayLargeSize => 10.sp;
  static double get displayMediumSize => 10.sp;
  static double get displaySmallSize => 10.sp;

  // body font size
  static double get body1TextSize => 10.sp;
  static double get body2TextSize => 10.sp;

  //button font size
  static double get buttonTextSize => 10.sp;

  //caption font size
  static double get captionTextSize => 10.sp;

  //chip font size
  static double get chipTextSize => 10.sp;
}