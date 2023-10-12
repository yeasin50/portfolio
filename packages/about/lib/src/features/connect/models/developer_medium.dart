part of 'contact.dart';

class StackOverflow extends Contact with OnTapMixin {
  const StackOverflow({required this.id});

  static const String key = 'stackOverflow';
  final String id;

  @override
  String toString() => "StackOverflow";
}

class GitHub extends Contact with OnTapMixin {
  const GitHub({required this.userId});

  static const String key = 'github';
  final String userId;

  @override
  String toString() {
    return "GitHub";
  }
}

class HackerRank extends Contact with OnTapMixin {
  const HackerRank({required this.username});

  static const String key = 'hackerRank';
  final String username;

  @override
  String toString() => "HackerRank";
}

///! need to test
class LeetCode extends Contact with OnTapMixin {
  const LeetCode({required this.username});

  static const String key = 'leetCode';
  final String username;

  @override
  String toString() => "LeetCode";
}

class OtherSite extends Contact with OnTapMixin {
  const OtherSite({
    required this.name,
    required this.url,
    required this.data,
  });

  static const String key = 'other';
  final String name;
  final String url;
  final String data;

  @override
  String toString() => name;
}
