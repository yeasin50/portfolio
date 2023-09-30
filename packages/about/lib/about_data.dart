import 'package:about/about.dart';

class AboutPageData {
  const AboutPageData({
    required this.certificates,
    required this.connectItems,
    required this.educations,
    required this.experiences,
    required this.skills,
  });

  final List<Certificate> certificates;
  final List<Contact> connectItems;
  final List<Education> educations;
  final List<Experience> experiences;
  final List<Skill> skills;
}
