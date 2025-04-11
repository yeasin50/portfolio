library education;

import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';

/// education  lifespan under a [Organization]
///
class Education {
  const Education({
    required this.school,
    required this.degree,
    this.field,
    required this.start,
    this.end,
    this.grade,
    this.description,
    this.images = const [],
    this.show = true,
  });

  final Organization school;
  final String degree;
  final String? field;
  final DateTime start;
  final DateTime? end;
  final String? grade;
  final String? description;
  final List<String> images;
  final bool show;

  @override
  String toString() {
    return 'Education(school: $school, degree: $degree, field: $field, start: $start, end: $end, grade: $grade, description: $description, images: $images)';
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    try {
      return Education(
        school: Organization.fromMap(map['school']),
        degree: map['degree'] ?? '',
        field: map['field'],
        start: DateTime.parse(map['start']),
        end: map['end'] != null ? DateTime.parse(map['end']) : null,
        grade: map['grade'],
        description: map['description'],
        images: List<String>.from(map['images'] ?? []),
        show: map["show"] ?? true,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  factory Education.fromJson(String source) =>
      Education.fromMap(json.decode(source));
}
