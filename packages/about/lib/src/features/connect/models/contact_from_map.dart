import 'package:flutter/foundation.dart';

import '../../../../about.dart';

/// This function will return a [List<Contact>] object based on the [Map] key.
@protected
List<Contact> contactFromJson(Map<String, dynamic> map) {
  List<Contact> contacts = [];

  for (final item in map.keys) {
    contacts.add(fromMapEntry(MapEntry(item, map[item])));
  }

  return contacts;
}

/// This function will return a [Contact] object based on the [MapEntry] key.
@protected
Contact fromMapEntry(MapEntry entry) {
  final Contact contact = switch (entry.key) {
    PhoneContact.key => PhoneContact(phoneNumber: entry.value),
    Email.key => Email(email: entry.value) as Contact, //! why do I need cast?
    Address.key => Address(address: entry.value),
    LinkedIn.key => entry.value.contains('linkedin.com')
        ? LinkedIn(username: entry.value.split('/').last)
        : LinkedIn(username: entry.value),
    Telegram.key => Telegram(username: entry.value),
    Website.key => Website(url: entry.value),

    // dev acc
    StackOverflow.key => StackOverflow(id: entry.value),
    GitHub.key => entry.value.contains('github.com')
        ? GitHub(userId: entry.value.split('/').last)
        : GitHub(userId: entry.value),
    HackerRank.key => entry.value.contains('hackerrank.com')
        ? HackerRank(username: entry.value.split('/').last)
        : HackerRank(username: entry.value),
    LeetCode.key => entry.value.contains('leetcode.com')
        ? LeetCode(username: entry.value.split('/').last)
        : LeetCode(username: entry.value),
    OtherSite.key => OtherSite(
        name: entry.value['name'],
        url: entry.value['url'],
        data: entry.value['data'],
      ),
    _ => entry.value is String
        ? OtherSite(
            name: entry.key,
            url: entry.value,
            data: entry.value,
          )
        : throw UnimplementedError(
            'Contact type ${entry.key} is not implemented yet'),
  };
  return contact;
}
