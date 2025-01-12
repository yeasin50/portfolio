///
extension SOProfileEXT on SoProfile {
  Map<String, int> get cardData => {
        "Reputation": reputation,
        "answers": totalAnswer,
        "questions": totalQuestion,
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
}
