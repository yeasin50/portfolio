///  to find on different media
class Connect {
  const Connect({
    required this.name,
    required this.logo,
    required this.url,
    this.description,
  });

  // site name, not so useful
  final String name;

  final String logo;
  final String url;

  /// might say how often I am active in this platform
  /// availability  ratio, but we can always put the first one at top
  final String? description;

  static Connect fromMap(Map<String, dynamic> map) {
    return Connect(
      name: map["name"],
      logo: map["logo"],
      url: map["url"],
      description: map["description"],
    );
  }
}
