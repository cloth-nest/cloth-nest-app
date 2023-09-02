import 'package:flutter/cupertino.dart';

class AppLanguages {
  AppLanguages._internal();

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
  ];

  static Locale fallbackLocale = supportedLocales.first;

  static String defaultLocaleString = supportedLocales.first.languageCode;
}
