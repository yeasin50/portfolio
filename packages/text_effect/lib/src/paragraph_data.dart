import 'dart:ui';

import 'package:core/core.dart';

class ParagraphData extends TextSpanData {
  ParagraphData({
    required super.text,
    super.bold,
    super.italic,
    super.url,
    this.isHovered = false,
    this.onTap,
  });

  bool isHovered;
  final VoidCallback? onTap;

  static ParagraphData fromSpan(
    TextSpanData span, {
    VoidCallback? onTap,
    bool? isHovered,
  }) {
    return ParagraphData(
      text: span.text,
      bold: span.bold,
      italic: span.italic,
      url: span.url,
      isHovered: isHovered ?? false,
      onTap: onTap,
    );
  }
}
