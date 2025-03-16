///
extension SOProfileEXT on SoProfile {
  Map<String, String> get cardData => {
        if (reached != null) "people reached": reached!,
        "Reputation": reputation.toString(),
        "answers": totalAnswer.toString(),
        "questions": totalQuestion.toString(),
      };

  Map<String, int> get badges => {
        "gold": goldBadgeCount,
        "silver": silverBadgeCount,
        "bronze": bronzeBadgeCount,
      };
}

///  stackOverflow user profile
class SoProfile {
  const SoProfile({
    required this.accountId,
    required this.reputation,
    required this.totalAnswer,
    required this.totalQuestion,
    required this.createdAt,
    required this.name,
    required this.avatarUrl,
    required this.profileUrl,
    required this.goldBadgeCount,
    required this.silverBadgeCount,
    required this.bronzeBadgeCount,
    this.reached,
  });

  final int accountId;
  final int reputation;
  final int totalAnswer;
  final int totalQuestion;
  final DateTime createdAt;

  final String name;
  final String avatarUrl;
  final String profileUrl;

  final int goldBadgeCount;
  final int silverBadgeCount;
  final int bronzeBadgeCount;
  final String? reached;

  factory SoProfile.fromMap(Map<String, dynamic> data) {
    final map = data["items"][0];

    return SoProfile(
      accountId: map['account_id']?.toInt() ?? 0,
      reputation: map['reputation']?.toInt() ?? 0,
      totalAnswer: map['answer_count']?.toInt() ?? 0,
      totalQuestion: map['question_count']?.toInt() ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['creation_date'] * 1000,
        isUtc: true,
      ),
      name: map['display_name'] ?? '',
      avatarUrl: map['profile_image'] ?? '',
      profileUrl: map['link'] ?? '',
      goldBadgeCount: map['badge_counts']["gold"]?.toInt() ?? 0,
      silverBadgeCount: map['badge_counts']["silver"]?.toInt() ?? 0,
      bronzeBadgeCount: map['badge_counts']["bronze"]?.toInt() ?? 0,
    );
  }

  SoProfile copyWith({
    int? accountId,
    int? reputation,
    int? totalAnswer,
    int? totalQuestion,
    DateTime? createdAt,
    String? name,
    String? avatarUrl,
    String? profileUrl,
    int? goldBadgeCount,
    int? silverBadgeCount,
    int? bronzeBadgeCount,
    String? reached,
  }) {
    return SoProfile(
      accountId: accountId ?? this.accountId,
      reputation: reputation ?? this.reputation,
      totalAnswer: totalAnswer ?? this.totalAnswer,
      totalQuestion: totalQuestion ?? this.totalQuestion,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      profileUrl: profileUrl ?? this.profileUrl,
      goldBadgeCount: goldBadgeCount ?? this.goldBadgeCount,
      silverBadgeCount: silverBadgeCount ?? this.silverBadgeCount,
      bronzeBadgeCount: bronzeBadgeCount ?? this.bronzeBadgeCount,
      reached: reached ?? this.reached,
    );
  }
}
