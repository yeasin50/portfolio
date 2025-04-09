import 'package:flutter/material.dart';

class NavigationTheme extends ThemeExtension<NavigationTheme> {
  const NavigationTheme({
    required this.activeColor,
    required this.inactiveColor,
    required this.hoverColor,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
  });

  final Color activeColor;
  final Color inactiveColor;
  final Color hoverColor;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;

  factory NavigationTheme.darkTheme() {
    return const NavigationTheme(
      activeColor: Color(0xFF4A6572),
      inactiveColor: Color.fromARGB(0, 255, 255, 255),
      hoverColor: Color(0xFF343C59),
      activeTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      inactiveTextStyle: TextStyle(
        color: Color(0xFF9E9E9E),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  factory NavigationTheme.dayTheme() {
    return const NavigationTheme(
      activeColor: Color(0xFF03A9F4),
      inactiveColor: Color.fromARGB(0, 255, 255, 255),
      hoverColor: Color(0xFFFFF9C4),
      activeTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      inactiveTextStyle: TextStyle(
        color: Color(0xFF454343),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  @override
  NavigationTheme copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? hoverColor,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
  }) {
    return NavigationTheme(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      hoverColor: hoverColor ?? this.hoverColor,
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
    );
  }

  @override
  NavigationTheme lerp(ThemeExtension<NavigationTheme>? other, double t) {
    if (other is! NavigationTheme) return this;

    return NavigationTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      activeTextStyle:
          TextStyle.lerp(activeTextStyle, other.activeTextStyle, t)!,
      inactiveTextStyle:
          TextStyle.lerp(inactiveTextStyle, other.inactiveTextStyle, t)!,
    );
  }
}
