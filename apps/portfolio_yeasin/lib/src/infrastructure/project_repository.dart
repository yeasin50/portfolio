import 'package:core/core.dart';
import 'package:portfolio_yeasin/src/infrastructure/api_service.dart';

import 'utils/get_resource.dart';

class ProjectRepository with GetResource {
  const ProjectRepository._(this._projects);

  final List<Project> _projects;
  List<Project> get projects => [..._projects];

  static Future<ProjectRepository> create(ApiService service) async {
    try {
      final List<Project> items = await service.getProjects();

      return ProjectRepository._(items);
    } catch (e) {
      rethrow;
    }
  }
}
