part of 'contact.dart';

class Twitter extends Contact {
  Twitter({required this.username});
  final String username;
}

class Youtube extends Contact {
  Youtube({required this.channel});

  final String channel;

  @override
  Future<void> onTap() async {
    final url = 'https://www.youtube.com/channel/$channel';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  String toString() => "Youtube:$channel";

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'channel': channel});

    return result;
  }

  factory Youtube.fromMap(Map<String, dynamic> map) {
    return Youtube(
      channel: map['channel'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Youtube.fromJson(String source) => Youtube.fromMap(json.decode(source));
}

class Medium extends Contact {
  Medium({required this.username});

  final String username;

  @override
  Future<void> onTap() async {
    final url = 'https://medium.com/@$username';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  String toString() {
    return "Medium: $username";
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});

    return result;
  }

  factory Medium.fromMap(Map<String, dynamic> map) {
    return Medium(
      username: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Medium.fromJson(String source) => Medium.fromMap(json.decode(source));
}
