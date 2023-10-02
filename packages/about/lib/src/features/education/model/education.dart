import 'dart:convert';
import 'dart:developer';

import '../../common/models/organization.dart';

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
  });

  final Organization school;
  final String degree;
  final String? field;
  final DateTime start;
  final DateTime? end;
  final String? grade;
  final String? description;
  final List<String> images;

  @override
  String toString() {
    return 'Education(school: $school, degree: $degree, field: $field, start: $start, end: $end, grade: $grade, description: $description, images: $images)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'school': school.toMap()});
    result.addAll({'degree': degree});
    if (field != null) {
      result.addAll({'field': field});
    }

    result.addAll({'start': start.millisecondsSinceEpoch});

    if (end != null) {
      result.addAll({'end': end!.millisecondsSinceEpoch});
    }
    if (grade != null) {
      result.addAll({'grade': grade});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'images': images});

    return result;
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    try {
      return Education(
        school: Organization.fromMap(map['school']),
        degree: map['degree'] ?? '',
        field: map['field'],
        start: DateTime.fromMillisecondsSinceEpoch(map['start']),
        end: map['end'] != null ? DateTime.fromMillisecondsSinceEpoch(map['end']) : null,
        grade: map['grade'],
        description: map['description'],
        images: List<String>.from(map['images']??[]),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory Education.fromJson(String source) => Education.fromMap(json.decode(source));
}
