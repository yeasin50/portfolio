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
  switch (entry.key) {
    case 'phone':
      return PhoneContact(phoneNumber: entry.value);
    case 'email':
      return Email(email: entry.value);
    case 'address':
      return Address(address: entry.value);
    case 'linkedin':
      return LinkedIn(username: entry.value);
    case 'telegram':
      return Telegram(username: entry.value);
    case 'website':
      return Website(url: entry.value);
    case 'twitter':
      return Twitter(username: entry.value);
    case 'youtube':
      return Youtube(channel: entry.value);
    case 'medium':
      return Medium(username: entry.value);
    case 'other':
      final Map<String, dynamic> data = entry.value;
      return OtherSite(
        name: data['name'],
        url: data['url'],
        data: data['data'],
      );
    default:
      return OtherSite(name: entry.key, url: entry.value, data: entry.value);
  }
}
