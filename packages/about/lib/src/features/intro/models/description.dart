import 'dart:convert';

class Description {
  const Description({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  final String imageUrl;
  final String title;
  final String description;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'imageUrl': imageUrl});
    result.addAll({'title': title});
    result.addAll({'description': description});

    return result;
  }

  factory Description.fromMap(Map<String, dynamic> map) {
    return Description(
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Description.fromJson(String source) => Description.fromMap(json.decode(source));

  @override
  String toString() => 'Description(imageUrl: $imageUrl, title: $title, description: $description)';
}
