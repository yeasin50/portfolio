import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      onTap: () => data.$2,
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

(IconData icon, Future<void>? onTap) getItem(Contact contact) {
  final data = switch (contact.runtimeType) {
    PhoneContact => (FontAwesomeIcons.phone, (contact as PhoneContact).onTap()),
    Email => (Icons.email, (contact as Email).onTap()),
    Address => (Icons.location_on, null),
    LinkedIn => (FontAwesomeIcons.linkedinIn, (contact as LinkedIn).onTap()),
    Telegram => (FontAwesomeIcons.telegram, (contact as Telegram).onTap()),
    Website => (Icons.web, (contact as Website).onTap()),
    StackOverflow => (FontAwesomeIcons.stackOverflow, (contact as StackOverflow).onTap()),
    GitHub => (FontAwesomeIcons.github, (contact as GitHub).onTap()),
    HackerRank => (FontAwesomeIcons.hackerrank, (contact as HackerRank).onTap()),
    LeetCode => (FontAwesomeIcons.link, (contact as LeetCode).onTap()),
    OtherSite => (FontAwesomeIcons.link, (contact as OtherSite).onTap()),
    _ => throw UnimplementedError(),
  };

  return data;
}
