import 'package:flutter/material.dart';

enum AppThemeMode {
  dark,
  light,
  soft,
}

class AppThemeConfig {
  static List<Color> backgroundColor({
    bool isDark = false,
    double lerp = 1,
  }) {
    return isDark
        ? [
            Color.lerp(
              const Color(0xFF1E1E30),
              const Color(0xFF3D3D5C),
              lerp,
            )!,
            Color.lerp(
              const Color(0xFF24243E),
              const Color(0xFF4A4A6A),
              lerp,
            )!
          ]
        : [
            Color.lerp(
              const Color(0xFFB2EBF2),
              const Color(0xFFFFF3E0),
              lerp,
            )!,
            Color.lerp(
              const Color(0xFFE3F2FD),
              const Color(0xFFEDE7F6),
              lerp,
            )!
          ];
  }

  static ThemeData data(AppThemeMode mode) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      extensions: switch (mode) {
        AppThemeMode.dark => [AppTheme.darkTheme()],
        AppThemeMode.light => [AppTheme.dayTheme()],
        _ => [AppTheme.darkTheme()],
      },
    );
  }
}

class AppTheme extends ThemeExtension<AppTheme> {
  final List<Color> backgroundGradient;
  final Color primaryText;
  final Color secondaryText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color mutedText; // Muted or disabled text color

  const AppTheme({
    required this.backgroundGradient,
    required this.primaryText,
    required this.secondaryText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.mutedText,
  });

  static AppTheme darkTheme() {
    return const AppTheme(
      backgroundGradient: [
        Color(0xFF1E2036), // Deep Blue-Gray
        Color(0xFF343C59), // Muted Slate Blue
      ],
      primaryText: Color(0xFFFFFFFF),
      secondaryText: Color(0xFFB0BEC5),
      buttonColor: Color(0xFF4A6572),
      buttonTextColor: Color(0xFFFFFFFF),
      mutedText: Color(0xFF9E9E9E),
    );
  }

  static AppTheme dayTheme() {
    return const AppTheme(
      backgroundGradient: [
        Color(0xFFB3E5FC), // Light Baby Blue
        Color(0xFFFFF9C4), // Soft Warm Yellow
      ],
      primaryText: Color(0xFF212121),
      secondaryText: Color(0xFF757575),
      buttonColor: Color(0xFF03A9F4),
      buttonTextColor: Color(0xFFFFFFFF),
      mutedText: Color(0xFFBDBDBD),
    );
  }

  @override
  AppTheme copyWith({
    List<Color>? backgroundGradient,
    Color? primaryText,
    Color? secondaryText,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? mutedText,
  }) {
    return AppTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      mutedText: mutedText ?? this.mutedText,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;

    return AppTheme(
      backgroundGradient: List<Color>.generate(
        backgroundGradient.length,
        (index) => Color.lerp(
          backgroundGradient[index],
          other.backgroundGradient[index],
          t,
        )!,
      ),
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t)!,
      mutedText: Color.lerp(mutedText, other.mutedText, t)!,
    );
  }
}
