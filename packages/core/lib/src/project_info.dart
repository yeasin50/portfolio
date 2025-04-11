import 'project_media.dart';

class Project {
  const Project({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
    this.thumbnail,
    required this.media,
    required this.description,
    required this.roll,
    required this.tasks,
    this.deployed,
    this.source,
    this.show = true,
  });

  final String id;

  /// project name or something short
  final String title;
  final String description;

  /// what type of project is this
  final String category;

  ///  a short name about your project roll
  ///  Designer, developer, etc
  final String roll;

  final DateTime createdAt;

  ///  an overview media will show on  tile
  final ProjectMedia? thumbnail;

  final List<ProjectMediaGroup> media;

  ProjectMedia? get hoverItem {
    for (final mg in media) {
      for (final m in mg.data) {
        if (m.isHoverItem) return m;
      }
    }
    return null;
  }

  ///  what you've done here
  /// what, why, how answers
  final List<String> tasks;

  ///  usual place we put the source e.g github
  final String? source;

  /// live site/store url
  final String? deployed;

  final bool show;

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      id: map["id"]?.toString() ?? DateTime.now().toString(),
      title: map["title"] ?? "Untitled",
      description: map["description"] ?? "",
      category: map["category"] ?? "Unknown",
      roll: map["roll"] ?? "Unknown",
      createdAt: DateTime.tryParse(map["created_at"] ?? "") ?? DateTime.now(),
      tasks: List.from(map["tasks"] ?? []),
      deployed: map["deployed"],
      source: map["source"],
      thumbnail: map["thumbnail"] != null
          ? ProjectMedia.fromMap(map["thumbnail"])
          : null,
      media: (map["media"] as List?)
              ?.map((e) => ProjectMediaGroup.fromMap(e))
              .toList() ??
          [],
      show: map["show"] ?? true,
    );
  }

  static Project ui = Project(
    id: "1",
    title: "Game of Life",
    description:
        "In search of efficient grid rendering, found and create something beautiful  about life",
    category: "Flutter",
    createdAt: DateTime(2024),
    media: [
      ProjectMediaGroup(
        title: "How to render thousands of widgets",
        data: [
          const ProjectMedia(
            type: "yt",
            value: "https://youtu.be/lQwjJTCrwVg?si=Jly-P483UdCx8He3",
          ),
        ],
      )
    ],
    roll: "special",
    tasks: [
      "Efficient way  of rendering thousands of grid inside fragment shader",
      "player with Inherited widget as state-management solution",
    ],
  );
}
