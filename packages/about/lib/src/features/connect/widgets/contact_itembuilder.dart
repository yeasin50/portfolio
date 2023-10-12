import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_utils/my_utils.dart';

import '../../../../about.dart';

class ContactItemBuilder extends StatelessWidget {
  const ContactItemBuilder({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final data = getItem(contact);
    return InkWell(
      onTap: () {
        logger.i('launching ${contact.runtimeType}');
        data.$2?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.$1),
          const SizedBox(width: 8),
          Text(
            contact.toString(),
          ),
        ],
      ),
    );
  }
}

/// This function will return a [IconData] and [Function] based on the [Contact] type.
/// * [Address] will return [Icons.location_on] and [null]
/// ! [Contact] type must be implemented in [contactFromJson] function.
/// else it will throw [UnimplementedError]
(IconData icon, Function? onTap) getItem(Contact contact) {
  final data = switch (contact.runtimeType) {
    PhoneContact => (FontAwesomeIcons.phone, (contact as PhoneContact).onTap),
    Email => (Icons.email, (contact as Email).onTap),
    Address => (Icons.location_on, null),
    LinkedIn => (FontAwesomeIcons.linkedinIn, (contact as LinkedIn).onTap),
    Telegram => (FontAwesomeIcons.telegram, (contact as Telegram).onTap),
    Website => (Icons.web, (contact as Website).onTap),
    StackOverflow => (
        FontAwesomeIcons.stackOverflow,
        (contact as StackOverflow).onTap
      ),
    GitHub => (FontAwesomeIcons.github, (contact as GitHub).onTap),
    HackerRank => (FontAwesomeIcons.hackerrank, (contact as HackerRank).onTap),
    LeetCode => (FontAwesomeIcons.link, (contact as LeetCode).onTap),
    OtherSite => (FontAwesomeIcons.link, (contact as OtherSite).onTap),
    _ => throw UnimplementedError(),
  };

  return data;
}
