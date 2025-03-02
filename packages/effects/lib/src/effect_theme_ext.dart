import 'package:flutter/material.dart';

@immutable
class EffectThemeExt extends ThemeExtension<EffectThemeExt> {
  final ButtonStyle neonButtonStyle;
  final Color glowColor;

  /// used for background decoration  on  ExpansionTile
  final List<Color> cardColor;

  const EffectThemeExt({
    required this.neonButtonStyle,
    required this.glowColor,
    required this.cardColor,
  });

  static final _shape = WidgetStateProperty.resolveWith((states) {
    return StadiumBorder();
  });

  static final _padding = WidgetStatePropertyAll(
    const EdgeInsets.symmetric(
      horizontal: 32,
      vertical: 8,
    ),
  );

  static EffectThemeExt dark = EffectThemeExt(
    glowColor: Colors.cyanAccent,
    cardColor: [Colors.blueGrey, Colors.black87],
    neonButtonStyle: ButtonStyle(
      padding: _padding,
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.cyanAccent.withAlpha(150);
        } else if (states.contains(WidgetState.hovered)) {
          return Colors.cyanAccent.withAlpha(100);
        } else if (states.contains(WidgetState.focused)) {
          return Colors.cyanAccent.withAlpha(120);
        }
        return Color(0xFF4A6572);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      shadowColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.cyanAccent.withAlpha(230);
        } else if (states.contains(WidgetState.hovered)) {
          return Colors.cyanAccent.withAlpha(180);
        }
        return Colors.transparent;
      }),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return 12;
        } else if (states.contains(WidgetState.hovered)) {
          return 8;
        }
        return 6;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.cyanAccent.withAlpha(50);
        }
        return Colors.transparent;
      }),
      shape: _shape,
    ),
  );

  static EffectThemeExt day = EffectThemeExt(
    glowColor: Colors.blueAccent,
    cardColor: [Colors.white, Colors.lightBlue.shade100],
    neonButtonStyle: ButtonStyle(
      padding: _padding,
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.blueAccent.withAlpha(150);
        } else if (states.contains(WidgetState.hovered)) {
          return Colors.blueAccent.withAlpha(100);
        } else if (states.contains(WidgetState.focused)) {
          return Colors.blueAccent.withAlpha(120);
        }
        return Color(0xFF03A9F4);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      shadowColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.blueAccent.withAlpha(230);
        } else if (states.contains(WidgetState.hovered)) {
          return Colors.blueAccent.withAlpha(180);
        }
        return Colors.transparent;
      }),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return 12;
        } else if (states.contains(WidgetState.hovered)) {
          return 8;
        }
        return 6;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.blueAccent.withAlpha(50);
        }
        return Colors.transparent;
      }),
      shape: _shape,
    ),
  );

  @override
  EffectThemeExt copyWith({
    ButtonStyle? neonButtonStyle,
    Color? glowColor,
    List<Color>? cardColor,
  }) {
    return EffectThemeExt(
      cardColor: cardColor ?? this.cardColor,
      neonButtonStyle: neonButtonStyle ?? this.neonButtonStyle,
      glowColor: glowColor ?? this.glowColor,
    );
  }

  @override
  ThemeExtension<EffectThemeExt> lerp(
      ThemeExtension<EffectThemeExt>? other, double t) {
    if (other is! EffectThemeExt) return this;
    return EffectThemeExt(
      cardColor: lerpColorList(cardColor, other.cardColor, t),
      neonButtonStyle:
          ButtonStyle.lerp(neonButtonStyle, other.neonButtonStyle, t)!,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
    );
  }
}

List<Color> lerpColorList(List<Color> a, List<Color> b, double t) {
  assert(a.length == b.length, 'lists must have the same length');

  return List<Color>.generate(a.length, (index) {
    return Color.lerp(a[index], b[index], t)!;
  });
}
