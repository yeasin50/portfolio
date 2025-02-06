import 'package:flutter/material.dart';

class SkillThemeExt extends ThemeExtension<SkillThemeExt> {
  final TextStyle labelTextStyle;
  final List<Color> backgroundColor;
  final List<Color> hoverColor;
  final TextStyle descriptionTextStyle;

  const SkillThemeExt({
    required this.labelTextStyle,
    required this.backgroundColor,
    required this.hoverColor,
    required this.descriptionTextStyle,
  });

  static SkillThemeExt darkTheme() {
    return SkillThemeExt(
      labelTextStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      backgroundColor: const [
        Color(0xFF1E2036),
        Color(0xFF343C59),
      ],
      hoverColor: const [
        Color(0xFF343C59),
        Color(0xFF4A6572),
      ],
      descriptionTextStyle: const TextStyle(color: Color(0xFFB0BEC5)),
    );
  }

  static SkillThemeExt dayTheme() {
    return SkillThemeExt(
      labelTextStyle: const TextStyle(color: Color(0xFF212121)),
      backgroundColor: const [
        Color(0xFFB3E5FC),
        Color(0xFFFFF9C4),
      ],
      hoverColor: const [
        Color(0xFFFFF9C4),
        Color(0xFF03A9F4),
      ],
      descriptionTextStyle: const TextStyle(color: Color(0xFF757575)),
    );
  }

  @override
  SkillThemeExt copyWith({
    TextStyle? labelTextStyle,
    List<Color>? backgroundColor,
    List<Color>? hoverColor,
    TextStyle? descriptionTextStyle,
  }) {
    return SkillThemeExt(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverColor: hoverColor ?? this.hoverColor,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    );
  }

  @override
  SkillThemeExt lerp(ThemeExtension<SkillThemeExt>? other, double t) {
    if (other is! SkillThemeExt) return this;
    return SkillThemeExt(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      backgroundColor: [
        Color.lerp(backgroundColor[0], other.backgroundColor[0], t)!,
        Color.lerp(backgroundColor[1], other.backgroundColor[1], t)!,
      ],
      hoverColor: [
        Color.lerp(hoverColor[0], other.hoverColor[0], t)!,
        Color.lerp(hoverColor[1], other.hoverColor[1], t)!,
      ],
      descriptionTextStyle:
          TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t)!,
    );
  }
}
