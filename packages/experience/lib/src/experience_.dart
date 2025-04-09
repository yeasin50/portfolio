import 'dart:convert';

import 'package:core/core.dart';

///
class Experience {
  const Experience({
    required this.title,
    required this.organization,
    required this.start,
    this.end,
    this.description,
  });

  final String title;
  final Organization? organization;

  final DateTime start;
  final DateTime? end;
  final String? description;

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'] ?? '',
      organization: map['organization'] != null
          ? Organization.fromMap(map['organization'] ?? {})
          : null,
      start: DateTime.parse(map['start']),
      end: map['end'] != null ? DateTime.parse(map['end']) : null,
      description: map['description'],
    );
  }

  factory Experience.fromJson(String source) =>
      Experience.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Experience(title: $title, company: $organization, start: $start, end: $end, description: $description)';
  }
}
