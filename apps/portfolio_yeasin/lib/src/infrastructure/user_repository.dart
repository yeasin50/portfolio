import 'dart:convert';

import 'package:contact/contact.dart';
import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_yeasin/src/infrastructure/connect_repo.dart';

import 'dart:io' if (dart.library.html) 'dummy.dart' as io;

import 'project_repository.dart';
import 'utils/get_resource.dart';

///
/// handle all the info about user
///
class UserRepository {
  const UserRepository._({
    required this.intro,
    required this.connects,
    required this.experiences,
    required this.educations,
    required this.certificates,
    required this.projects,
    this.connectData,
  });

  final IntroInfo intro;
  // I wont recommend more than 4, use about section
  final List<Connect> connects;

  /// best 3
  final List<Experience> experiences;

  /// 1/2
  final List<Education> educations;

  /// top 3
  final List<Certificate> certificates;

  /// bump everything, will add config on main page to control max item
  final List<Project> projects;

  /// handles and limit,reason  of connecting with me
  final IConnectRepo? connectData;

  ///  create new instance to pass down the widget tree
  ///
  static Future<UserRepository> create() async {
    var response =
        await GetResource.fetchResponse("resource/json/user_info.json");

    final data = jsonDecode(response);

    final intro = IntroInfo.fromMap(data["intro"]);
    final experiences = List<Experience>.from(
        data['experience'].map((e) => Experience.fromMap(e)));

    final connects =
        List<Connect>.from(data['connects'].map((e) => Connect.fromMap(e)));

    final education = List<Education>.from(
        data['education'].map((e) => Education.fromMap(e)));

    final certificate = List<Certificate>.from(
        data['certificate'].map((e) => Certificate.fromMap(e)));

    final connectRepo = await UserConnectRepo.create();
    final projectRepo = await ProjectRepository.create();

    return UserRepository._(
      intro: intro,
      connects: connects,
      experiences: experiences,
      educations: education,
      certificates: certificate,
      projects: projectRepo.projects,
      connectData: connectRepo,
    );
  }
}
