import 'dart:convert';

import 'employment_type.dart';
import 'location_type.dart';

class Experience {
  const Experience({
    required this.title,
    required this.company,
    required this.type,
    this.location,
    required this.start,
    this.end,
    this.description,
    this.logo,
  });

  final String title;
  final String company;
  final EmploymentType type;
  final LocationType? location;
  final DateTime start;
  final DateTime? end;
  final String? description;
  final String? logo;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'company': company});
    result.addAll({'type': type.name});
    if (location != null) {
      result.addAll({'location': location!.name});
    }
    result.addAll({'start': start.millisecondsSinceEpoch});
    if (end != null) {
      result.addAll({'end': end!.millisecondsSinceEpoch});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (logo != null) {
      result.addAll({'logo': logo});
    }

    return result;
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      type: EmploymentType.values.firstWhere((element) => element.name == map['type']),
      location: map['location'] != null ? LocationType.values.firstWhere((element) => element.name == map['location']) : null,
      start: DateTime.fromMillisecondsSinceEpoch(map['start']),
      end: map['end'] != null ? DateTime.fromMillisecondsSinceEpoch(map['end']) : null,
      description: map['description'],
      logo: map['logo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Experience.fromJson(String source) => Experience.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Experience(title: $title, company: $company, type: $type, location: $location, start: $start, end: $end, description: $description, logo: $logo)';
  }
}
