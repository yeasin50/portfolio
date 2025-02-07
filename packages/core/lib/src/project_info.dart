import 'project_media.dart';

class Project {
  const Project({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
    required this.thumbnail,
    required this.media,
    required this.description,
    required this.roll,
    required this.tasks,
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
  final String thumbnail;

  final List<ProjectMediaGroup> media;

  ///  what you've done here
  /// what, why, how answers
  final List<String> tasks;

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      id: map["id"] ?? DateTime.now().toString(),
      title: map["title"],
      description: map["description"] ?? "",
      category: map["category"],
      roll: map["roll"],
      createdAt: DateTime.parse(map["created_at"]),
      tasks: List.from(map["tasks"]),
      thumbnail: map["thumbnail"],
      media: List<ProjectMediaGroup>.from(
        map["media"]?.map((e) => ProjectMediaGroup.fromMap(e)),
      ),
    );
  }

  static Project ui = Project(
    id: "1",
    title: "Game of Life",
    description:
        "In search of efficient grid rendering, found and create something beautiful  about life",
    category: "Flutter",
    createdAt: DateTime(2024),
    thumbnail: "https://img.youtube.com/vi/lQwjJTCrwVg/hqdefault.jpg",
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
