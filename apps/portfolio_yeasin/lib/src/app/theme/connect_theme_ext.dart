import 'package:flutter/material.dart';

@immutable
class ActionThemeExt extends ThemeExtension<ActionThemeExt> {
  final Color iconColor;
  final Color borderColor;
  final Color background;
  final Color hoverColor;
  final TextStyle hintTextStyle;
  final Color hintBackgroundColor;

  const ActionThemeExt({
    required this.iconColor,
    required this.borderColor,
    required this.background,
    required this.hoverColor,
    required this.hintTextStyle,
    required this.hintBackgroundColor,
  });
  static ActionThemeExt darkTheme() => const ActionThemeExt(
        iconColor: Color(0xFFE0F7FA),
        // iconFocusedColor: Color(0xFFB3E5FC),
        borderColor: Color(0xFF90A4AE),
        background: Color(0xFF222437),
        hoverColor: Color(0xFF2E344B),
        hintTextStyle: TextStyle(
          color: Color(0xFFB0BEC5),
          fontSize: 12,
        ),
        hintBackgroundColor: Color(0xFF2A2D48),
      );

  static ActionThemeExt dayTheme() => const ActionThemeExt(
        iconColor: Color(0xFF455A64),
        // iconFocusedColor: Color(0xFF0277BD),
        borderColor: Color(0xFF039BE5),
        background: Color(0xFFBBDEFB),
        hoverColor: Color(0xFFFFF59D),
        hintTextStyle: TextStyle(
          color: Color(0xFF78909C),
          fontSize: 12,
        ),
        hintBackgroundColor: Color(0xFFAEDFF7),
      );

  @override
  ActionThemeExt copyWith({
    Color? iconColor,
    Color? borderColor,
    Color? background,
    Color? hoverColor,
    TextStyle? hintTextStyle,
    Color? hintBackgroundColor,
  }) {
    return ActionThemeExt(
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      background: background ?? this.background,
      hoverColor: hoverColor ?? this.hoverColor,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      hintBackgroundColor: hintBackgroundColor ?? this.hintBackgroundColor,
    );
  }

  @override
  ActionThemeExt lerp(ThemeExtension<ActionThemeExt>? other, double t) {
    if (other is! ActionThemeExt) return this;
    return ActionThemeExt(
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      background: Color.lerp(background, other.background, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      hintTextStyle: TextStyle.lerp(hintTextStyle, other.hintTextStyle, t)!,
      hintBackgroundColor:
          Color.lerp(hintBackgroundColor, other.hintBackgroundColor, t)!,
    );
  }
}
