class ProjectMediaGroup {
  const ProjectMediaGroup({
    required this.title,
    required this.data,
    this.description,
  });

  final String title;
  final String? description;
  final List<ProjectMedia> data;

  static ProjectMediaGroup fromMap(Map<String, dynamic> map) {
    return ProjectMediaGroup(
      title: map["title"],
      description: map["description"],
      data: List.from(
        map["data"].map(
          (e) => ProjectMedia.fromMap(e),
        ),
      ),
    );
  }
}

class ProjectMedia {
  const ProjectMedia({
    required this.type,
    required this.value,
    this.blurHash,
  });

  /// mediaType can be text, image or video link,
  /// including yt, github,
  final String type;

  final String value;

  /// show on loading widgets
  /// !https://pub.dev/packages/flutter_blurhash
  final String? blurHash;

  static ProjectMedia fromMap(Map<String, dynamic> map) {
    return ProjectMedia(
      type: map["type"],
      value: map["value"],
      blurHash: map["blur_hash"]
    );
  }
}

//todo: extension to categorize the itemType
