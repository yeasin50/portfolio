///  user's badges gold, silver,bronze for different topics
///! more on  https://stackoverflow.com/help/badges
///
class SOBadge {
  const SOBadge({
    required this.rank,
    required this.awardCount,
    required this.badgeId,
    required this.description,
    required this.name,
    required this.link,
  });

  final String rank;
  final int awardCount;
  final int badgeId;
  final String description;
  final String name;
  final String link;

  factory SOBadge.fromMap(Map<String, dynamic> map) {
    return SOBadge(
      rank: map['rank'] ?? '',
      link: map["link"] ?? "",
      awardCount: map['award_count']?.toInt() ?? 0,
      badgeId: map['badge_id']?.toInt() ?? 0,
      description: map['description'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
