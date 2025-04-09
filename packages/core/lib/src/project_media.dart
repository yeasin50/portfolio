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
    this.lowRes,
  });

  /// mediaType can be text, image or video link,
  /// including yt, github,
  final String type;

  final String value;

  ///  to show low resolution  image
  final String? lowRes;

  /// show on loading widgets
  /// !https://pub.dev/packages/flutter_blurhash
  final String? blurHash;

  bool get isHoverItem => type == "hover_play";
  static ProjectMedia fromMap(Map<String, dynamic> map) {
    return ProjectMedia(
      type: map["type"],
      value: map["value"],
      blurHash: map["blur_hash"],
      lowRes: map["low_res"],
    );
  }
}

//todo: extension to categorize the itemType
