class Repository {
  const Repository({
    required this.name,
    required this.description,
    required this.forkCount,
    required this.createdAt,
    this.updatedAt,
    required this.totalStars,
    required this.url,
    required this.languages,
    required this.isPrivate,
  });

  final String name;
  final String description;
  final int forkCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int totalStars;
  final String url;
  final RepoLanguage? languages;
  final bool isPrivate;

  factory Repository.fromMap(Map<String, dynamic> map) {
    return Repository(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      forkCount: map['forkCount']?.toInt() ?? 0,
      isPrivate: map['isPrivate'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      totalStars: map['stargazerCount']?.toInt() ?? 0,
      url: map['url'] ?? '',
      languages: RepoLanguage.fromMap(
        map['languages'],
      ),
    );
  }
}

class RepoLanguage {
  final int total;
  final List<String> names;
  final List<String> colors;

  const RepoLanguage({
    required this.total,
    required this.names,
    required this.colors,
  });

  factory RepoLanguage.fromMap(Map<String, dynamic> map) {
    return RepoLanguage(
      total: map['totalCount']?.toInt() ?? 0,
      names: List<String>.from(map["nodes"]?.map((e) => e?["name"])),
      colors: List<String>.from(map["nodes"]?.map((e) => e?["color"])),
    );
  }
}
