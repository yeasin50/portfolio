import 'dart:developer';

/// used to render textSpan for [AdvanceRichText] and [ParagraphPainter]   text-effects
///
class TextSpanData {
  TextSpanData({
    required this.text,
    this.url,
    this.bold,
    this.italic,
    this.dialog,
  });

  ///  base text
  final String text;

  /// when we like to navigate on click,
  /// will have underline text
  final String? url;

  /// for dialog
  final TextSpanDialogData? dialog;

  /// whether make it bold
  final bool? bold;
  final bool? italic;

  factory TextSpanData.fromMap(Map<String, dynamic> map) {
    log("dialog data : ${map["dialog"]}");
    return TextSpanData(
      text: map['text'] ?? '',
      url: map['url'],
      bold: map['bold'],
      italic: map['italic'],
      dialog: map["dialog"] != null
          ? TextSpanDialogData.fromMap(map["dialog"])
          : null,
    );
  }

  TextSpanData copyWith({
    String? text,
    String? url,
    TextSpanDialogData? dialog,
    bool? bold,
    bool? italic,
  }) {
    return TextSpanData(
      text: text ?? this.text,
      url: url ?? this.url,
      dialog: dialog ?? this.dialog,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
    );
  }
}

/// this is part of [TextSpanData] when  we have dialog
///
class TextSpanDialogData {
  const TextSpanDialogData({
    required this.title,
    required this.description,
    required this.items,
  });

  final String title;
  final String description;
  final List<String> items;

  factory TextSpanDialogData.fromMap(Map<String, dynamic> map) {
    return TextSpanDialogData(
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      items: List<String>.from(map["items"] ?? []),
    );
  }
}
