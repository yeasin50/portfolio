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
