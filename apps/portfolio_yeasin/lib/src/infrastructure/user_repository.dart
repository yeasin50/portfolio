import 'package:contact/contact.dart';
import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/api_service.dart';
import 'package:portfolio_yeasin/src/infrastructure/connect_repo.dart';
import 'package:portfolio_yeasin/src/infrastructure/models/user_info_response.dart';

import '../app/app_config.dart';
import 'project_repository.dart';

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
  static Future<UserRepository> create(AppConfig config) async {
    final apiService = ApiService(config.baseUrl);

    try {
      final response = await Future.wait([
        apiService.getUserInfo(),
        UserConnectRepo.create(apiService),
        ProjectRepository.create(apiService)
      ]);

      final userInfo = response.first as UserInfoResponse;
      final connectRepo = response[1] as UserConnectRepo;
      final projectRepo = response.last as ProjectRepository;

      return UserRepository._(
        intro: userInfo.into,
        connects: userInfo.connects.where((e) => e.show).toList(),
        experiences: userInfo.experience.where((e) => e.show).toList(),
        educations: userInfo.education.where((e) => e.show).toList(),
        certificates: userInfo.certificates.where((e) => e.show).toList(),
        projects: projectRepo.projects.where((e) => e.show).toList(),
        connectData: connectRepo,
      );
    } catch (e, st) {
      debugPrint("error ${e}\n st $st");
      rethrow;
    }
  }
}
