import 'package:flutter/material.dart';

class WorkCardTheme extends ThemeExtension<WorkCardTheme> {
  const WorkCardTheme({
    required this.bgColor,
    required this.titleStyle,
    required this.descriptionStyle,
    required this.buttonStyle,
    required this.hoverColor,
  });

  final Color bgColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final ButtonStyle buttonStyle;

  final Color hoverColor;

  static WorkCardTheme darkCardTheme() {
    return const WorkCardTheme(
      bgColor: Color(0xCC2A2D42),
      hoverColor: Color(0xFF4A6572),
      titleStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      descriptionStyle: TextStyle(
        color: Color(0xFFB0BEC5),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xFF4A6572)),
        foregroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static WorkCardTheme dayCardTheme() {
    return const WorkCardTheme(
      bgColor: Color(0x99E1F5FE),
      hoverColor: Color(0xFF81D4FA),
      titleStyle: TextStyle(
        color: Color(0xFF212121),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      descriptionStyle: TextStyle(
        color: Color(0xFF757575),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xFF03A9F4)),
        foregroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  ThemeExtension<WorkCardTheme> copyWith({
    Color? bgColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    ButtonStyle? buttonStyle,
    Color? hoverColor,
  }) {
    return WorkCardTheme(
      bgColor: bgColor ?? this.bgColor,
      hoverColor: hoverColor ?? this.hoverColor,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }

  @override
  ThemeExtension<WorkCardTheme> lerp(
      covariant ThemeExtension<WorkCardTheme>? other, double t) {
    if (other is! WorkCardTheme) return this;
    return WorkCardTheme(
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      descriptionStyle:
          TextStyle.lerp(descriptionStyle, other.descriptionStyle, t)!,
      buttonStyle: ButtonStyle.lerp(buttonStyle, other.buttonStyle, t)!,
    );
  }
}
