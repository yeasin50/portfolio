part of 'contact.dart';

class PhoneContact extends Contact with OnTapMixin {
  const PhoneContact({required this.phoneNumber});

  static const String key = 'phone';
  final String phoneNumber;

  @override
  String toString() => phoneNumber;
}

class Email extends Contact with OnTapMixin {
  const Email({required this.email});

  static const String key = 'email';
  final String email;

  @override
  String toString() => email;
}

class Address extends Contact {
  const Address({required this.address});

  static const String key = 'address';
  final String address;

  @override
  String toString() => address;
}

class LinkedIn extends Contact with OnTapMixin {
  const LinkedIn({required this.username});

  static const String key = 'linkedIn';
  final String username;

  @override
  String toString() => "LinkedIn";
}

class Telegram extends Contact with OnTapMixin {
  const Telegram({required this.username});

  static const String key = 'telegram';
  final String username;

  @override
  String toString() => "Telegram";
}

class Website extends Contact with OnTapMixin {
  const Website({required this.url});

  static const String key = 'website';
  final String url;

  @override
  String toString() => url.split('//').last;
}
