import 'package:flutter/material.dart';

import '../../../../about.dart';

class ContactView extends StatelessWidget {
  const ContactView({
    super.key,
    required this.connects,
  });

  final List<Contact> connects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
