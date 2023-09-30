part of 'contact.dart';

class Twitter extends Contact with OnTapMixin {
  Twitter({required this.username});
  final String username;
}

class Youtube extends Contact with OnTapMixin {
  Youtube({required this.channel});

  final String channel;

  @override
  String toString() => "Youtube:$channel";
}

class Medium extends Contact {
  Medium({required this.username});

  final String username;

  @override
  String toString() {
    return "Medium: $username";
  }
}
