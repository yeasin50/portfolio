import 'dart:convert';

class Skill {
  const Skill({
    required this.type,
    required this.skills,
  });

  // this will be the title like "Programming Languages", "Frameworks", etc.
  final String type;
  final List<String> skills;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type});
    result.addAll({'skills': skills});

    return result;
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      type: map['type'] ?? '',
      skills: List<String>.from(map['skills']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) => Skill.fromMap(json.decode(source));
}
