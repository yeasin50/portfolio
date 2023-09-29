import 'package:flutter/material.dart';

import '../../../../about.dart';
import '../../common/widgets/link_textview.dart';

class ContactView extends StatelessWidget {
  const ContactView({
    super.key,
    required this.connects,
  });

  final List<Contact> connects;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Connect',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        ...connects.map((e) => ContactItemBuilder(contact: e)),
      ],
    );
  }
}

class ContactItemBuilder extends StatelessWidget {
  const ContactItemBuilder({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return LinkTextView(
      paragraph: contact.toString(),
      onTap: () async {
        await contact.onTap();
      },
    );
  }
}