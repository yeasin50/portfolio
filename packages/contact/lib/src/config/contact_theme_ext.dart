import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///  theme gonna use inside contact features
/// make sure to provide inside the MaterialTheme's Extension
///
class ContactThemeExt extends ThemeExtension<ContactThemeExt> {
  // Constructor
  const ContactThemeExt({
    required this.expandIconColor,
    required this.pageTitle,
    required this.tldr,
    required this.itemTitle,
    required this.itemSubTitle,
    required this.itemStyle,
  });

  final Color expandIconColor;
  final TextStyle pageTitle;
  final TextStyle tldr;
  final TextStyle itemTitle;
  final TextStyle itemSubTitle;
  final TextStyle itemStyle;

  @override
  ContactThemeExt copyWith({
    Color? expandIconColor,
    TextStyle? pageTitle,
    TextStyle? tldr,
    TextStyle? itemTitle,
    TextStyle? itemSubTitle,
    TextStyle? itemStyle,
  }) {
    return ContactThemeExt(
      expandIconColor: expandIconColor ?? this.expandIconColor,
      pageTitle: pageTitle ?? this.pageTitle,
      tldr: tldr ?? this.tldr,
      itemTitle: itemTitle ?? this.itemTitle,
      itemSubTitle: itemSubTitle ?? this.itemSubTitle,
      itemStyle: itemStyle ?? this.itemStyle,
    );
  }

  @override
  ContactThemeExt lerp(ThemeExtension<ContactThemeExt>? other, double t) {
    if (other is! ContactThemeExt) return this;

    return ContactThemeExt(
      expandIconColor: Color.lerp(expandIconColor, other.expandIconColor, t)!,
      pageTitle: TextStyle.lerp(pageTitle, other.pageTitle, t)!,
      tldr: TextStyle.lerp(tldr, other.tldr, t)!,
      itemTitle: TextStyle.lerp(itemTitle, other.itemTitle, t)!,
      itemSubTitle: TextStyle.lerp(itemSubTitle, other.itemSubTitle, t)!,
      itemStyle: TextStyle.lerp(itemStyle, other.itemStyle, t)!,
    );
  }

  // Dark Theme
  static ContactThemeExt darkTheme() {
    return ContactThemeExt(
      expandIconColor: Color(0xFFB0BEC5), // Light Gray
      pageTitle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
      tldr: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFB0BEC5),
      ),
      itemTitle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
      itemSubTitle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9E9E9E),
      ),
      itemStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFB0BEC5),
      ),
    );
  }

  // Day Theme
  static ContactThemeExt dayTheme() {
    return const ContactThemeExt(
      expandIconColor: Color(0xFF0288D1), // Light Blue
      pageTitle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF212121),
      ),
      tldr: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF757575),
      ),
      itemTitle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF212121),
      ),
      itemSubTitle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFFBDBDBD),
      ),
      itemStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF757575),
      ),
    );
  }

  @override
  String toString() {
    return 'ContactThemeExt(expandIconColor: $expandIconColor, pageTitle: $pageTitle, tldr: $tldr, itemTitle: $itemTitle, itemSubTitle: $itemSubTitle, itemStyle: $itemStyle)';
  }
}
