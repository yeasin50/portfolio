import 'dart:convert';

class Skill {
  const Skill({
    required this.type,
    required this.values,
    required this.levels,
  }) : assert(values.length == levels.length, 'values and levels must have the same length');

  // this will be the title like "Programming Languages", "Frameworks", etc.
  final String type;
  final List<String> values;

  /// use decimal to represent the level of skill between 0 and 1
  final List<double> levels;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type});
    result.addAll({'values': values});
    result.addAll({'levels': levels});

    return result;
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      type: map['type'] ?? '',
      values: List<String>.from(map['values']),
      levels: List<double>.from(map['levels']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) => Skill.fromMap(json.decode(source));
}
