part of 'contact.dart';

class Twitter extends Contact with OnTapMixin {
  Twitter({required this.username});

  static const String key = 'twitter';
  final String username;
}

class Youtube extends Contact with OnTapMixin {
  Youtube({required this.channel});

  static const String key = 'youtube';
  final String channel;

  @override
  String toString() => "Youtube:$channel";
}

class Medium extends Contact {
  Medium({required this.username});

  static const String key = 'medium';
  final String username;

  @override
  String toString() {
    return "Medium: $username";
  }
}
