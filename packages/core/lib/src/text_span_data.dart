/// used to render textSpan for [AdvanceRichText] and [ParagraphPainter]   text-effects
///
class TextSpanData {
  TextSpanData({
    required this.text,
    this.url,
    this.bold,
    this.italic,
  });

  ///  base text
  final String text;

  /// when  we like to navigate on click,
  /// will  have underline text
  final String? url;

  /// whether make it bold
  final bool? bold;
  final bool? italic;

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
  }) {
    return TextSpanData(
      text: text ?? this.text,
      url: url ?? this.url,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
    );
  }
}
