import 'dart:convert';

class Description {
  const Description({
    required this.imageUrl,
    this.imageHash,
    required this.title,
    required this.description,
  });

  final String imageUrl;
  final String? imageHash;
  final String title;
  final String description;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'imageUrl': imageUrl});

    if (imageHash != null) {
      result.addAll({'imageHash': imageHash});
    }
    result.addAll({'title': title});

    result.addAll({'description': description});

    return result;
  }

  factory Description.fromMap(Map<String, dynamic> map) {
    return Description(
      imageUrl: map['imageUrl'] ?? '',
      imageHash: map['imageHash'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Description.fromJson(String source) =>
      Description.fromMap(json.decode(source));

  @override
  String toString() =>
      'Description(imageUrl: $imageUrl, title: $title, description: $description)';
}
