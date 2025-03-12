import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import 'dart:convert';
import 'dart:io' if (dart.library.html) 'dummy.dart' as io;

class ProjectRepository {
  const ProjectRepository._(this._projects);

  final List<Project> _projects;
  List<Project> get projects => [..._projects];

  static Future<ProjectRepository> create() async {
    try {
      var response;
      if (kDebugMode) {
        final currentDir = io.Directory.current.path;
        final filePath = '$currentDir\\..\\..\\resource\\json\\projects.json';
        print("exits here ${await io.File(filePath).exists()}");
        response = await io.File(filePath).readAsString();
      } else {
        throw UnimplementedError('Network fetch is not implemented.');
      }

      final data = jsonDecode(response)["data"] as List?;

      final List<Project> items =
          List<Project>.from(data?.map((e) => Project.fromMap(e)) ?? []);

      return ProjectRepository._(items);
    } catch (e) {
      rethrow;
    }
  }
}
