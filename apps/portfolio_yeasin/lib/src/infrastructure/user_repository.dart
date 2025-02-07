import 'dart:convert';

import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/services.dart';

///
/// handle all the info about user
///
class UserRepository {
  const UserRepository._({
    required this.intro,
    required this.experiences,
    required this.educations,
    required this.certificates,
    required this.projects,
  });

  final IntroInfo intro;
  final List<Experience> experiences;
  final List<Education> educations;
  final List<Certificate> certificates;
  final List<Project> projects;

  ///  create new instance to pass down the widget tree
  /// 
  static Future<UserRepository> create() async {
    //todo: http
    final response = await rootBundle.loadString("assets/user_info.json");
    final data = jsonDecode(response);

    final intro = IntroInfo.fromMap(data["intro"]);
    final experiences = List<Experience>.from(
      data['experience'].map(
        (e) => Experience.fromMap(e),
      ),
    );

    final education = List<Education>.from(
      data['education'].map(
        (e) => Education.fromMap(e),
      ),
    );

    final certificate = List<Certificate>.from(
      data['certificate'].map(
        (e) => Certificate.fromMap(e),
      ),
    );

    final projects = List<Project>.from(
      data['projects'].map(
        (e) => Project.fromMap(e),
      ),
    );

    return UserRepository._(
      intro: intro,
      experiences: experiences,
      educations: education,
      certificates: certificate,
      projects: projects,
    );
  }
}
