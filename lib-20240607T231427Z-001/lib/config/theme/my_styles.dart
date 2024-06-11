import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dark_theme_colors.dart';
import 'my_fonts.dart';
import 'light_theme_colors.dart';

class MyStyles {
   static double _screenWidth = 700;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
  }

  static IconThemeData getIconTheme({required bool isLightTheme}) {
    double iconSize = _screenWidth < 700 ? 30 :28 ;
    return IconThemeData(
      color: isLightTheme ? LightThemeColors.iconColor : DarkThemeColors.iconColor,
      size: iconSize,
    );
  }

  static AppBarTheme getAppBarTheme({required bool isLightTheme}) {
    double fontSize = _screenWidth < 700 ? 12 : 20;
    double iconSize = _screenWidth < 700 ? 20 : 12;
    return AppBarTheme(
      elevation: 50,
      titleTextStyle: getTextTheme(isLightTheme: isLightTheme).bodyMedium!.copyWith(
        color: Colors.black,
        fontSize: fontSize.sp,
      ),
      iconTheme: IconThemeData(
        color: isLightTheme ? LightThemeColors.appBarIconsColor : DarkThemeColors.appBarIconsColor,
        size: iconSize.sp,
      ),
      backgroundColor: isLightTheme ? LightThemeColors.appBarColor : DarkThemeColors.appbarColor,
    );
  }

  static TextTheme getTextTheme({required bool isLightTheme}) {
    double fontSize = _screenWidth < 700 ? 12 : 12;
    return TextTheme(
      labelLarge: MyFonts.buttonTextStyle.copyWith(
        fontSize: fontSize.sp,
      ),
      bodyLarge: (MyFonts.bodyTextStyle).copyWith(
        fontWeight: FontWeight.bold,
        fontSize: fontSize.sp,
        color: isLightTheme ? LightThemeColors.bodyTextColor : DarkThemeColors.bodyTextColor,
      ),
      bodyMedium: (MyFonts.bodyTextStyle).copyWith(
        fontSize: fontSize.sp,
        color: isLightTheme ? LightThemeColors.bodyTextColor : DarkThemeColors.bodyTextColor,
      ),
      displayLarge: (MyFonts.displayTextStyle).copyWith(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold,
        color: isLightTheme ? LightThemeColors.displayTextColor : DarkThemeColors.displayTextColor,
      ),
      bodySmall: TextStyle(
        color: isLightTheme ? LightThemeColors.bodySmallTextColor : DarkThemeColors.bodySmallTextColor,
        fontSize: fontSize.sp,
      ),
      displayMedium: (MyFonts.displayTextStyle).copyWith(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold,
        color: isLightTheme ? LightThemeColors.displayTextColor : DarkThemeColors.displayTextColor,
      ),
      displaySmall: (MyFonts.displayTextStyle).copyWith(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold,
        color: isLightTheme ? LightThemeColors.displayTextColor : DarkThemeColors.displayTextColor,
      ),
    );
  }

  static ChipThemeData getChipTheme({required bool isLightTheme}) {
    return ChipThemeData(
      backgroundColor: isLightTheme ? LightThemeColors.chipBackground : DarkThemeColors.chipBackground,
      brightness: Brightness.light,
      labelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      secondaryLabelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      selectedColor: Colors.black,
      disabledColor: Colors.green,
      padding: EdgeInsets.all(2.sp),
      secondarySelectedColor: Colors.purple,
    );
  }

  static TextStyle getChipTextStyle({required bool isLightTheme}) {
    double fontSize = _screenWidth < 700 ? 6 : 10;
    return MyFonts.chipTextStyle.copyWith(
      fontSize: fontSize.sp,
      color: isLightTheme ? LightThemeColors.chipTextColor : DarkThemeColors.chipTextColor,
    );
  }

  static MaterialStateProperty<TextStyle?>? getElevatedButtonTextStyle(
      bool isLightTheme, {
        bool isBold = true,
      }) {
    double fontSize = _screenWidth < 700 ? 6 : 10;
    return MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return MyFonts.buttonTextStyle.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize.sp,
            color: isLightTheme ? LightThemeColors.buttonTextColor : DarkThemeColors.buttonTextColor,
          );
        } else if (states.contains(MaterialState.disabled)) {
          return MyFonts.buttonTextStyle.copyWith(
            fontSize: fontSize.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isLightTheme
                ? LightThemeColors.buttonDisabledTextColor
                : DarkThemeColors.buttonDisabledTextColor,
          );
        }
        return MyFonts.buttonTextStyle.copyWith(
          fontSize: fontSize.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: isLightTheme ? LightThemeColors.buttonTextColor : DarkThemeColors.buttonTextColor,
        );
      },
    );
  }

  static ElevatedButtonThemeData getElevatedButtonTheme({required bool isLightTheme}) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.sp),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 4.sp, horizontal: 12.sp),
          ),
          textStyle: getElevatedButtonTextStyle(isLightTheme),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return isLightTheme
                    ? LightThemeColors.buttonColor.withOpacity(0.5)
                    : DarkThemeColors.buttonColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return isLightTheme ? LightThemeColors.buttonDisabledColor : DarkThemeColors.buttonDisabledColor;
              }
              return isLightTheme ? LightThemeColors.buttonColor : DarkThemeColors.buttonColor;
            },
          ),
        ),
      );
}