import 'package:flutter/cupertino.dart';

class AppLanguages {
  AppLanguages._internal();

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];

  static Locale enLocale = supportedLocales[0];

  static Locale viLocale = supportedLocales[1];

  static Locale fallbackLocale = supportedLocales.first;

  static String defaultLocaleString = supportedLocales.first.languageCode;
}
