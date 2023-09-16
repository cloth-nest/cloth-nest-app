import 'dart:io' show Platform;

import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final String fontFamily = Platform.isIOS ? 'Hiragino Sans' : 'Roboto';
final double lightHeight = Platform.isIOS ? 1.3 : 1;
const String fontSFPro = 'SF Pro Text';

class AppThemes {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 45,
      height: 53.7 / 45,
      color: AppColors.textLightBasic,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: lightHeight,
      color: AppColors.textLightBasic,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 24 / 16,
      color: AppColors.textLightBasic,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 13,
      height: 19.5 / 13,
      color: AppColors.textLightBasic,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 19.6 / 14,
      color: AppColors.textLightBasic,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 12,
      height: 18 / 12,
      color: AppColors.textLightBasic,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 12,
      height: 16.8 / 12,
      color: AppColors.textLightBasic,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 10,
      height: 15 / 10,
      color: AppColors.textLightBasic,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 9,
      height: 13.5 / 9,
      color: AppColors.textLightBasic,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 9,
      height: Platform.isIOS ? 14.6 / 9 : 12.6 / 9,
      color: AppColors.textLightBasic,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 9,
      height: 15.3 / 9,
      color: AppColors.textLightBasic,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 15.0,
      height: 22.5 / 15.0,
      color: AppColors.textLightBasic,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
      height: 21.0 / 14.0,
      color: AppColors.textLightBasic,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 12.0,
      height: 18.0 / 12.0,
      color: AppColors.textLightBasic,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 11.0,
      height: Platform.isIOS ? 14.13 / 11.0 : 13.13 / 11.0,
      color: AppColors.textLightBasic,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 45,
      height: 53.7 / 45,
      color: AppColors.textDarkBasic,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: lightHeight,
      color: AppColors.textDarkBasic,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 24 / 16,
      color: AppColors.textDarkBasic,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 13,
      height: 19.5 / 13,
      color: AppColors.textDarkBasic,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 19.6 / 14,
      color: AppColors.textDarkBasic,
    ),
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 12,
      height: 18 / 12,
      color: AppColors.textDarkBasic,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 12,
      height: 16.8 / 12,
      color: AppColors.textDarkBasic,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 10,
      height: 15 / 10,
      color: AppColors.textDarkBasic,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 9,
      height: 13.5 / 9,
      color: AppColors.textDarkBasic,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 9,
      height: Platform.isIOS ? 14.6 / 9 : 12.6 / 9,
      color: AppColors.textDarkBasic,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 9,
      height: 15.3 / 9,
      color: AppColors.textDarkBasic,
    ),
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 15.0,
      height: 22.5 / 15.0,
      color: AppColors.textDarkBasic,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
      height: 21.0 / 14.0,
      color: AppColors.textDarkBasic,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      fontSize: 12.0,
      height: 18.0 / 12.0,
      color: AppColors.textDarkBasic,
    ),
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 11.0,
      height: 13.13 / 11.0,
      color: AppColors.textLightBasic,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.skyPerfectBlue,
    scaffoldBackgroundColor: AppColors.backgroundLightMode,
    appBarTheme: const AppBarTheme(color: AppColors.backgroundLightMode),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: AppColors.backgroundLightMode),
    inputDecorationTheme: const InputDecorationTheme(
      // labelStyle: TextStyle(
      //     fontSize: 10,
      //     fontWeight: FontWeight.w300,
      //     color: AppColors.iconActive),
      hintStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        color: AppColors.textGray999,
      ),
    ),
    textTheme: lightTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [
      ExtensionColors.lightTheme(),
    ],
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.skyPerfectBlue,
    scaffoldBackgroundColor: AppColors.backgroundDarkMode,
    appBarTheme: const AppBarTheme(color: AppColors.backgroundDarkMode),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: AppColors.backgroundDarkMode),
    inputDecorationTheme: const InputDecorationTheme(
      // labelStyle: TextStyle(
      //     fontSize: 10,
      //     fontWeight: FontWeight.w300,
      //     color: AppColors.iconActive),
      hintStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        color: AppColors.textGray999,
      ),
    ),
    textTheme: darkTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [
      ExtensionColors.darkTheme(),
    ],
  );
}
