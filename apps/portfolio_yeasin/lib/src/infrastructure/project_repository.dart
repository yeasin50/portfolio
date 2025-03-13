import 'package:core/core.dart';

import 'dart:convert';

import 'utils/get_resource.dart';

class ProjectRepository with GetResource {
  const ProjectRepository._(this._projects);

  final List<Project> _projects;
  List<Project> get projects => [..._projects];

  static Future<ProjectRepository> create() async {
    try {
      var response =
          await GetResource.fetchResponse("resource/json/projects.json");

      final data = jsonDecode(response)["data"] as List?;

      final List<Project> items =
          List<Project>.from(data?.map((e) => Project.fromMap(e)) ?? []);

      return ProjectRepository._(items);
    } catch (e) {
      rethrow;
    }
  }
}
