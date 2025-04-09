class GithubUser {
  const GithubUser({
    required this.id,
    required this.name,
    required this.avatar,
    required this.link,
    required this.totalStars,
    required this.totalRepo,
    required this.totalGist,
    required this.followers,
    required this.following,
    required this.createdDate,
  });

  final String name;
  final String avatar;
  final String link;
  final String id;

  /// public
  final int totalStars;
  final int totalRepo;
  final int totalGist;
  final int followers;
  final int following;

  final DateTime createdDate;

  factory GithubUser.fromMap(Map<String, dynamic> viewer) {
    return GithubUser(
      id: viewer["login"],
      name: viewer['name'] ?? '',
      avatar: viewer['avatar_url'] ?? '',
      link: viewer['html_url'] ?? '',
      totalRepo: viewer["public_repos"]?.toInt() ?? 0,
      totalGist: viewer["public_gists"]?.toInt() ?? 0,
      totalStars: viewer['totalStars']?.toInt() ?? 0,
      followers: viewer['followers']?.toInt() ?? 0,
      following: viewer['following']?.toInt() ?? 0,
      createdDate: DateTime.parse(viewer['created_at']),
    );
  }
}
