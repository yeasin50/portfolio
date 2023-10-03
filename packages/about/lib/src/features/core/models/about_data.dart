import 'dart:convert';
import 'dart:developer';

import 'package:about/about.dart';

class AboutPageData {
  const AboutPageData({
    required this.name,
    required this.description,
    required this.certificates,
    required this.contacts,
    required this.educations,
    required this.experiences,
    required this.skills,
  });

  final Name name;
  final Description description;
  final List<Certificate> certificates;
  final List<Contact> contacts;
  final List<Education> educations;
  final List<Experience> experiences;
  final List<Skill> skills;

  factory AboutPageData.fromMap(Map<String, dynamic> map) {
    try {
      return AboutPageData(
        name: Name.fromMap(map['name']),
        description: Description.fromMap(map['description']),
        certificates: List<Certificate>.from(
            map['certificates']?.map((x) => Certificate.fromMap(x))),
        contacts: contactFromJson(map['contacts']),
        educations: List<Education>.from(
            map['educations']?.map((x) => Education.fromMap(x))),
        experiences: List<Experience>.from(
            map['experiences']?.map((x) => Experience.fromMap(x))),
        skills: List<Skill>.from(map['skills']?.map((x) => Skill.fromMap(x))),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  factory AboutPageData.fromJson(String source) =>
      AboutPageData.fromMap(json.decode(source));
}
