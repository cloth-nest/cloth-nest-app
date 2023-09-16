import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

@immutable
class ExtensionColors extends ThemeExtension<ExtensionColors> {
  const ExtensionColors({
    required this.placeholder,
    required this.line,
    required this.labelColor,
    required this.buttonTextActiveColor,
    required this.outlineButtonTextColor,
    required this.skyPerfectBlue,
  });

  final Color? placeholder;
  final Color? line;
  final Color? labelColor;
  final Color? buttonTextActiveColor;
  final Color? outlineButtonTextColor;
  final Color? skyPerfectBlue;

  /// initial factory constructor based file enums.dart
  //////////////////////////////////////////////////////////
  // Color scheme for normal
  //////////////////////////////////////////////////////////

  /// light theme
  factory ExtensionColors.lightTheme() => const ExtensionColors(
        placeholder: AppColors.placeholderLightMode,
        line: AppColors.lineLightBasic,
        labelColor: AppColors.textDarkBasic,
        buttonTextActiveColor: AppColors.textDarkBasic,
        outlineButtonTextColor: AppColors.textGray666,
        skyPerfectBlue: AppColors.skyPerfectBlue,
      );

  /// dark theme
  factory ExtensionColors.darkTheme() => const ExtensionColors(
        placeholder: AppColors.placeholderDarkMode,
        line: AppColors.lineDarkBasic,
        labelColor: AppColors.textLightBasic,
        buttonTextActiveColor: AppColors.textDarkBasic,
        outlineButtonTextColor: AppColors.textGray666,
        skyPerfectBlue: AppColors.skyPerfectBlue,
      );

  @override
  ThemeExtension<ExtensionColors> copyWith({
    Color? placeholder,
    Color? line,
    Color? labelColor,
    Color? buttonTextActiveColor,
    Color? outlineButtonTextColor,
    Color? skyPerfectBlue,
  }) {
    return ExtensionColors(
      placeholder: placeholder ?? this.placeholder,
      line: line ?? this.line,
      labelColor: labelColor ?? this.labelColor,
      buttonTextActiveColor:
          buttonTextActiveColor ?? this.buttonTextActiveColor,
      outlineButtonTextColor:
          outlineButtonTextColor ?? this.outlineButtonTextColor,
      skyPerfectBlue: skyPerfectBlue ?? this.skyPerfectBlue,
    );
  }

  // Controls how the properties change on theme changes
  @override
  ThemeExtension<ExtensionColors> lerp(
    covariant ThemeExtension<ExtensionColors>? other,
    double t,
  ) {
    if (other is! ExtensionColors) {
      return this;
    }
    return ExtensionColors(
      placeholder: Color.lerp(placeholder, other.placeholder, t),
      line: Color.lerp(line, other.line, t),
      labelColor: Color.lerp(labelColor, other.labelColor, t),
      buttonTextActiveColor:
          Color.lerp(buttonTextActiveColor, other.buttonTextActiveColor, t),
      outlineButtonTextColor:
          Color.lerp(outlineButtonTextColor, other.outlineButtonTextColor, t),
      skyPerfectBlue: Color.lerp(skyPerfectBlue, other.skyPerfectBlue, t),
    );
  }
}
