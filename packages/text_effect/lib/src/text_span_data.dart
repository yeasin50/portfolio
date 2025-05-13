import 'dart:ui';

/// used to render textSpan for [AdvanceRichText] and [ParagraphPainter]   text-effects
///
class TextSpanData {
  TextSpanData({
    required this.text,
    this.url,
    this.bold,
    this.italic,
    this.isHovered = false,
    this.onTap,
  });

  ///  base text
  final String text;

  /// when  we like to navigate on click,
  /// will  have underline text
  final String? url;

  /// whether make it bold
  final bool? bold;
  final bool? italic;

  ///  will use for mouse hover effect
  ///
  bool isHovered;

  /// handle onTap function for [url] on  ui
  ///
  final VoidCallback? onTap;

  factory TextSpanData.fromMap(Map<String, dynamic> map) {
    return TextSpanData(
      text: map['text'] ?? '',
      url: map['url'],
      bold: map['bold'],
      italic: map['italic'],
    );
  }

  TextSpanData copyWith({
    String? text,
    String? url,
    bool? bold,
    bool? italic,
    VoidCallback? onTap,
  }) {
    return TextSpanData(
      text: text ?? this.text,
      url: url ?? this.url,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      onTap: onTap ?? this.onTap,
    );
  }
}
