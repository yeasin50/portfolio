import 'package:flutter/material.dart';

class ExperienceTheme extends ThemeExtension<ExperienceTheme> {
  final TextStyle titleStyle;
  final TextStyle organizationTextStyle;
  final TextStyle descriptionStyle;
  final TextStyle dateTextStyle;
  final Color backgroundColor;
  final Color borderColor;

  const ExperienceTheme({
    required this.titleStyle,
    required this.organizationTextStyle,
    required this.descriptionStyle,
    required this.dateTextStyle,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  ExperienceTheme copyWith({
    TextStyle? titleStyle,
    TextStyle? organizationTextStyle,
    TextStyle? descriptionStyle,
    TextStyle? dateTextStyle,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return ExperienceTheme(
      titleStyle: titleStyle ?? this.titleStyle,
      organizationTextStyle:
          organizationTextStyle ?? this.organizationTextStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      dateTextStyle: dateTextStyle ?? this.dateTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  ThemeExtension<ExperienceTheme> lerp(
      covariant ThemeExtension<ExperienceTheme>? other, double t) {
    if (other is! ExperienceTheme) return this;

    return ExperienceTheme(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      organizationTextStyle: TextStyle.lerp(
          organizationTextStyle, other.organizationTextStyle, t)!,
      descriptionStyle:
          TextStyle.lerp(descriptionStyle, other.descriptionStyle, t)!,
      dateTextStyle: TextStyle.lerp(dateTextStyle, other.dateTextStyle, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }

  static ExperienceTheme darkTheme() {
    return const ExperienceTheme(
      titleStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      organizationTextStyle: TextStyle(
        color: Color(0xFF90CAF9), // Soft Blue for organization text
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      descriptionStyle: TextStyle(
        color: Color(0xFFB0BEC5),
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      dateTextStyle: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 12.0,
        fontStyle: FontStyle.italic,
      ),
      backgroundColor: Color(0xFF1A1D33), // Dark Indigo-Gray
      borderColor: Color(0xFF343C59), // Muted Slate Blue
    );
  }

  static ExperienceTheme dayTheme() {
    return const ExperienceTheme(
      titleStyle: TextStyle(
        color: Color(0xFF212121),
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      organizationTextStyle: TextStyle(
        color: Color(0xFF0288D1), // Vibrant Blue for organization text
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      descriptionStyle: TextStyle(
        color: Color(0xFF757575),
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      dateTextStyle: TextStyle(
        color: Color(0xFFBDBDBD),
        fontSize: 12.0,
        fontStyle: FontStyle.italic,
      ),
      backgroundColor: Color(0xFFFFFDE7), // Light Warm Cream
      borderColor: Color(0xFFB3E5FC), // Baby Blue
    );
  }
}
