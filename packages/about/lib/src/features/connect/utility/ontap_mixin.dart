import 'package:url_launcher/url_launcher.dart';

import '../connect.dart';

mixin OnTapMixin{
  Future<void> onTap() async {
    //should only use on child Contact class
    assert(
      this is Contact,
      'OnTapMixin should only be used on Contact class',
    );
    switch (runtimeType) {
      case PhoneContact:
        await phoneCall((this as PhoneContact).phoneNumber);
        break;

      case Email:
        await mailTo((this as Email).email);
        break;

      case LinkedIn:
        final username = (this as LinkedIn).username;
        await launchWeb('https://www.linkedin.com/in/$username');
        break;

      case Telegram:
        final username = (this as Telegram).username;
        await launchWeb('https://t.me/$username');
        break;

      case Website:
        final url = (this as Website).url;
        await launchWeb(url);
        break;

      case StackOverflow:
        final id = (this as StackOverflow).id;
        await launchWeb('https://stackoverflow.com/users/$id');
        break;

      case GitHub:
        final userId = (this as GitHub).userId;
        await launchWeb('https://github.com/$userId');
        break;

      case Twitter:
        final username = (this as Twitter).username;
        await launchWeb('https://twitter.com/$username');
        break;

      case HackerRank:
        final username = (this as HackerRank).username;
        await launchWeb('https://www.hackerrank.com/$username');
        break;

      case Youtube:
        final channel = (this as Youtube).channel;
        await launchWeb('https://www.youtube.com/channel/$channel');
        break;

      case OtherSite:
        final url = (this as OtherSite).url;
        await launchWeb(url);
        break;
    }
  }

  Future<void> phoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> mailTo(String email) async {
    final url = 'mailto:$email';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchWeb(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
