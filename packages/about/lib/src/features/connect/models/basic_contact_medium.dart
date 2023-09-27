
part of 'contact.dart';

class PhoneContact implements Contact {
  const PhoneContact({required this.phoneNumber});

  final String phoneNumber;

  @override
  Future<void> onTap() async {
    final url = 'tel:$phoneNumber';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Email extends Contact {
  Email({required this.email});

  final String email;

  @override
  Future<void> onTap() async {
    final url = 'mailto:$email';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class LinkedIn extends Contact {
  LinkedIn({required this.username});

  final String username;

  @override
  Future<void> onTap() async {
    final url = 'https://www.linkedin.com/in/$username';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Telegram extends Contact {
  Telegram({required this.username});

  final String username;

  @override
  Future<void> onTap() async {
    final url = 'https://t.me/$username';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Website extends Contact {
  Website({required this.url});

  final String url;

  @override
  Future<void> onTap() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
