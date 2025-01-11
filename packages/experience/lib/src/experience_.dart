import 'dart:convert';

import 'package:core/core.dart';

///  
class Experience {
  const Experience({
    required this.title,
    required this.company,
    required this.start,
    this.end,
    this.description,
  });

  final String title;
  final Organization company;

  final DateTime start;
  final DateTime? end;
  final String? description;

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'] ?? '',
      company: Organization.fromMap(map['company'] ?? {}),
      start: DateTime.fromMillisecondsSinceEpoch(map['start']),
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end'])
          : null,
      description: map['description'],
    );
  }

  factory Experience.fromJson(String source) =>
      Experience.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Experience(title: $title, company: $company, start: $start, end: $end, description: $description)';
  }
}
