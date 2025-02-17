import 'package:flutter/material.dart';

@immutable
class OptionTheme {
  final List<Color> optionGradient;
  final Color spreedColor;
  final Color shadowColor;
  final TextStyle optionsTextStyle;
  final Color? hookColor;
  final List<Color> lineColor;

  const OptionTheme({
    required this.optionGradient,
    required this.spreedColor,
    required this.shadowColor,
    required this.optionsTextStyle,
    this.hookColor,
    required this.lineColor,
  });
}

@immutable
class ContactThemeExt extends ThemeExtension<ContactThemeExt> {
  final List<Color> background;
  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;
  final OptionTheme optionTheme;

  const ContactThemeExt({
    required this.background,
    required this.titleTextStyle,
    required this.descriptionTextStyle,
    required this.optionTheme,
  });

  static ContactThemeExt darkTheme() {
    return ContactThemeExt(
      background: [
        Color(0xFF0A0E21),
        Color(0xFF1C1F33),
      ],
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      descriptionTextStyle: const TextStyle(
        color: Color(0xFFB0BEC5),
        fontSize: 18,
      ),
      optionTheme: OptionTheme(
        optionGradient: [
          Color(0xFF4A148C),
          Color(0xFF6A1B9A),
        ],
        spreedColor: const Color(0xFFFFD700),
        shadowColor: const Color(0xFF1A237E),
        optionsTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        hookColor: const Color(0xFFBB86FC),
        lineColor: [
          Color(0xFFB39DDB),
          Color(0xFF9575CD),
        ],
      ),
    );
  }

  static ContactThemeExt dayTheme() {
    return ContactThemeExt(
      background: [
        Color(0xFF87CEEB),
        Color(0xFFFFD700),
      ],
      titleTextStyle: const TextStyle(
        color: Color(0xFF212121),
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      descriptionTextStyle: const TextStyle(
        color: Color(0xFF616161),
        fontSize: 18,
      ),
      optionTheme: OptionTheme(
        optionGradient: [
          Color(0xFF4FC3F7),
          Color(0xFFFFD740),
        ],
        spreedColor: const Color(0xFFFFA726),
        shadowColor: const Color(0xFF0277BD),
        optionsTextStyle: const TextStyle(
          color: Color(0xFF212121),
          fontSize: 16,
        ),
        hookColor: const Color(0xFFFF7043),
        lineColor: [
          Color(0xFF81D4FA),
          Color(0xFFFFF176),
        ],
      ),
    );
  }

  @override
  ContactThemeExt copyWith({
    List<Color>? background,
    TextStyle? titleTextStyle,
    TextStyle? descriptionTextStyle,
    OptionTheme? optionTheme,
  }) {
    return ContactThemeExt(
      background: background ?? this.background,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      optionTheme: optionTheme ?? this.optionTheme,
    );
  }

  @override
  ContactThemeExt lerp(ContactThemeExt? other, double t) {
    if (other == null) return this;

    return ContactThemeExt(
      background: [
        Color.lerp(background[0], other.background[0], t)!,
        Color.lerp(background[1], other.background[1], t)!,
      ],
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      descriptionTextStyle:
          TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t)!,
      optionTheme: OptionTheme(
        optionGradient: [
          Color.lerp(optionTheme.optionGradient[0],
              other.optionTheme.optionGradient[0], t)!,
          Color.lerp(optionTheme.optionGradient[1],
              other.optionTheme.optionGradient[1], t)!,
        ],
        spreedColor: Color.lerp(
            optionTheme.spreedColor, other.optionTheme.spreedColor, t)!,
        shadowColor: Color.lerp(
            optionTheme.shadowColor, other.optionTheme.shadowColor, t)!,
        optionsTextStyle: TextStyle.lerp(optionTheme.optionsTextStyle,
            other.optionTheme.optionsTextStyle, t)!,
        hookColor: other.optionTheme.hookColor != null &&
                optionTheme.hookColor != null
            ? Color.lerp(optionTheme.hookColor, other.optionTheme.hookColor, t)
            : optionTheme.hookColor,
        lineColor: [
          Color.lerp(
              optionTheme.lineColor[0], other.optionTheme.lineColor[0], t)!,
          Color.lerp(
              optionTheme.lineColor[1], other.optionTheme.lineColor[1], t)!,
        ],
      ),
    );
  }
}
