part of 'contact.dart';

class StackOverflow extends Contact with OnTapMixin {
  const StackOverflow({required this.id});

  final String id;

  @override
  String toString() => "StackOverflow";
}

class GitHub extends Contact with OnTapMixin {
  const GitHub({required this.userId});

  final String userId;

  @override
  String toString() {
    return "GitHub";
  }
}

class HackerRank extends Contact with OnTapMixin {
  const HackerRank({required this.username});

  final String username;

  @override
  String toString() => "HackerRank";
}

///! need to test
class LeetCode extends Contact with OnTapMixin {
  const LeetCode({required this.username});

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

  final String name;
  final String url;
  final String data;
}
