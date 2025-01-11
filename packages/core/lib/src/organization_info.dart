import 'dart:convert';

class Organization {
  const Organization({
    required this.name,
    this.logoUrl,
    this.websiteUrl,
    this.description,
  });

  final String name;
  final String? logoUrl;
  final String? websiteUrl;
  final String? description;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    if (logoUrl != null) {
      result.addAll({'logoUrl': logoUrl});
    }
    if (websiteUrl != null) {
      result.addAll({'websiteUrl': websiteUrl});
    }
    if (description != null) {
      result.addAll({'description': description});
    }

    return result;
  }

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      name: map['name'] ?? '',
      logoUrl: map['logoUrl'],
      websiteUrl: map['websiteUrl'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Organization.fromJson(String source) =>
      Organization.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Organization(name: $name, logoUrl: $logoUrl, websiteUrl: $websiteUrl, description: $description)';
  }
}
