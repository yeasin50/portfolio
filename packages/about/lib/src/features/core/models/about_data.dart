import 'dart:convert';

import 'package:about/about.dart';

class AboutPageData {
  const AboutPageData({
    required this.certificates,
    required this.contacts,
    required this.educations,
    required this.experiences,
    required this.skills,
  });

  final List<Certificate> certificates;
  final List<Contact> contacts;
  final List<Education> educations;
  final List<Experience> experiences;
  final List<Skill> skills;

  factory AboutPageData.fromMap(Map<String, dynamic> map) {
    return AboutPageData(
      certificates: List<Certificate>.from(map['certificates']?.map((x) => Certificate.fromMap(x))),
      contacts: contactFromJson(map['contacts']),
      educations: List<Education>.from(map['educations']?.map((x) => Education.fromMap(x))),
      experiences: [], // List<Experience>.from(map['experiences']?.map((x) => Experience.fromMap(x))),
      skills: [], // List<Skill>.from(map['skills']?.map((x) => Skill.fromMap(x))),
    );
  }

  factory AboutPageData.fromJson(String source) => AboutPageData.fromMap(json.decode(source));
}
