class GithubUser {
  const GithubUser({
    required this.name,
    required this.avatar,
    required this.link,
    required this.totalStars,
    required this.totalRepo,
    required this.followers,
    required this.following,
    required this.createdDate,
    this.contribution,
    this.status,
    this.repositories = const [],
  });

  final String name;
  final String avatar;
  final String link;

  final int? totalStars;
  final int? totalRepo;
  final int followers;
  final int following;

  final DateTime createdDate;

  final GitHubStatus? status;
  final Contribution? contribution;
  final List<Repository> repositories;

  factory GithubUser.fromMap(Map<String, dynamic> map) {
    final viewer = map["viewer"];

    final user = map["user"];
    final repoData = user?["repositories"]?["nodes"] ?? [];

    // try {//FIXME:
    //   final List<Repository> repos =
    //       repoData.map((e) => Repository.fromMap(e)).toList();
    // } catch (e, st) {
    //   print(e);
    //   print(st);
    // }

    return GithubUser(
      name: viewer['name'] ?? '',
      avatar: viewer['avatarUrl'] ?? '',
      link: viewer['url'] ?? '',
      totalStars: viewer['totalStars']?.toInt(),
      followers: viewer['followers']?["totalCount"]?.toInt() ?? 0,
      following: viewer['following']?["totalCount"]?.toInt() ?? 0,
      createdDate: DateTime.parse(viewer['createdAt']),
      contribution: Contribution.fromMap(viewer["contributionsCollection"]),
      status: GitHubStatus.fromMap(viewer["status"]),
      totalRepo: user['totalCount']?.toInt(),
      // repositories: repos,
    );
  }
}

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
        languages: RepoLanguage(total: 2, names: [], colors: [])
        // languages: RepoLanguage.fromMap(map['languages']),
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
      names: map["nodes"]?.map((e) => e?["name"])?.toList() ?? [],
      colors: map["nodes"]?.map((e) => e?["color"])?.toList() ?? [],
    );
  }
}

class GitHubStatus {
  const GitHubStatus({
    required this.message,
    required this.emoji,
  });

  static GitHubStatus fromMap(Map<String, dynamic> map) {
    return GitHubStatus(
      message: map["message"],
      emoji: map["emoji"],
    );
  }

  final String message;
  final String emoji;
}

class Contribution {
  const Contribution({
    required this.startedAt,
    required this.endAt,
    required this.totalCommit,
    required this.totalIssue,
    required this.totalPr,
    required this.totalPrReview,
    required this.totalRepoContribution,
  });

  final DateTime startedAt;
  final DateTime endAt;

  final int totalRepoContribution;
  final int totalCommit;
  final int totalIssue;
  final int totalPr;
  final int totalPrReview;

  factory Contribution.fromMap(Map<String, dynamic> map) {
    return Contribution(
      startedAt: DateTime.parse(map['startedAt']),
      endAt: DateTime.parse(map['endedAt']),
      totalRepoContribution: map["totalRepositoryContributions"],
      totalCommit: map['totalCommitContributions']?.toInt() ?? 0,
      totalIssue: map['totalIssueContributions']?.toInt() ?? 0,
      totalPr: map['totalPullRequestContributions']?.toInt() ?? 0,
      totalPrReview: map['totalPullRequestReviewContributions']?.toInt() ?? 0,
    );
  }
}
