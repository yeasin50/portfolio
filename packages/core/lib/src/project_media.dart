class ProjectMedia {
  const ProjectMedia({
    required this.type,
    required this.value,
  });

  /// mediaType can be text, image or video link,
  /// including yt, github,
  final String type;

  final String value;

  static ProjectMedia fromMap(Map<String, dynamic> map) {
    return ProjectMedia(
      type: map["type"],
      value: map["value"],
    );
  }
}

//todo: extension to categorize the itemType