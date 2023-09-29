part of 'contact.dart';

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
}
