part of 'contact.dart';

class StackOverflow extends Contact {
  const StackOverflow({required this.id});

  final String id;

  @override
  Future<void> onTap() async {
    final url = 'https://stackoverflow.com/users/$id';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  String toString() => "StackOverflow";
}

class HackerRank extends Contact {
  const HackerRank({required this.username});

  final String username;

  @override
  Future<void> onTap() async {
    final url = 'https://www.hackerrank.com/$username';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  String toString() => "HackerRank";
}

class LeetCode extends Contact {
  const LeetCode({required this.username});

  final String username;

  @override
  Future<void> onTap() async {
    final url = 'https://leetcode.com/$username';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  String toString() => "LeetCode";
}
