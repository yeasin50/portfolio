import 'package:flutter/material.dart';

@immutable
class StackOverflowTheme extends ThemeExtension<StackOverflowTheme> {
  const StackOverflowTheme({
    required this.titleStyle,
    required this.labelStyle,
    required this.gold,
    required this.silver,
    required this.bronze,
    required this.badgeTextStyle,
  });

  /// Title text style (for main headings)
  final TextStyle titleStyle;

  /// Label text style (for smaller labels or captions)
  final TextStyle labelStyle;

  /// Badge colors
  final Color gold;
  final Color silver;
  final Color bronze;

  /// Common badge text style
  final TextStyle badgeTextStyle;

  static StackOverflowTheme darkTheme() => const StackOverflowTheme(
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: TextStyle(
          color: Color(0xFFB0BEC5), // Secondary Text Color
          fontSize: 16,
        ),
        gold: Color(0xFFFFD700), // Gold Color
        silver: Color(0xFFC0C0C0), // Silver Color
        bronze: Color(0xFFCD7F32), // Bronze Color
        badgeTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );

  static StackOverflowTheme dayTheme() => const StackOverflowTheme(
        titleStyle: TextStyle(
          color: Color(0xFF212121),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: TextStyle(
          color: Color(0xFF757575), // Secondary Text Color
          fontSize: 16,
        ),
        gold: Color(0xFFFFD700), // Gold
        silver: Color(0xFFC0C0C0), // Silver
        bronze: Color(0xFFCD7F32), // Bronze
        badgeTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  StackOverflowTheme copyWith({
    TextStyle? titleStyle,
    TextStyle? labelStyle,
    Color? gold,
    Color? silver,
    Color? bronze,
    TextStyle? badgeTextStyle,
  }) {
    return StackOverflowTheme(
      titleStyle: titleStyle ?? this.titleStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      gold: gold ?? this.gold,
      silver: silver ?? this.silver,
      bronze: bronze ?? this.bronze,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
    );
  }

  @override
  ThemeExtension<StackOverflowTheme> lerp(
      covariant ThemeExtension<StackOverflowTheme>? other, double t) {
    if (other is! StackOverflowTheme) return this;
    return StackOverflowTheme(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      silver: Color.lerp(silver, other.silver, t)!,
      bronze: Color.lerp(bronze, other.bronze, t)!,
      badgeTextStyle: TextStyle.lerp(badgeTextStyle, other.badgeTextStyle, t)!,
    );
  }
}
