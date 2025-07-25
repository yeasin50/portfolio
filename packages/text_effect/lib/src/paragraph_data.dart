import 'dart:ui';

import 'package:core/core.dart';

///```dart
/// ParagraphData(
///  text: "gold badges as recognition.",
///
///  onTap: () {
///    debugPrint("tapped gold badges as recognition");
///  },
///  dialog: TextSpanDialogData(
///    title: "dialog title",
///    description: "descr",
///    items: [],
///  ),
///),
///```
class ParagraphData extends TextSpanData {
  ParagraphData({
    required super.text,
    super.bold,
    super.italic,
    super.url,
    super.dialog,
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
      dialog: span.dialog,
    );
  }

  @override
  ParagraphData copyWith({
    VoidCallback? onTap,
    String? text,
    String? url,
    TextSpanDialogData? dialog,
    bool? bold,
    bool? italic,
  }) {
    return ParagraphData(
      onTap: onTap ?? this.onTap,
      text: text ?? this.text,
      url: url ?? this.url,
      dialog: dialog ?? this.dialog,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
    );
  }
}
