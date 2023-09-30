part of 'contact.dart';

class PhoneContact extends Contact with OnTapMixin {
  const PhoneContact({required this.phoneNumber});

  final String phoneNumber;

  @override
  String toString() => phoneNumber;
}

class Email extends Contact with OnTapMixin {
  const Email({required this.email});

  final String email;

  @override
  String toString() => email;
}

class Address extends Contact {
  final String address;

  const Address({required this.address});
}

class LinkedIn extends Contact with OnTapMixin {
  const LinkedIn({required this.username});

  final String username;

  @override
  String toString() => "LinkedIn";
}

class Telegram extends Contact with OnTapMixin {
  const Telegram({required this.username});

  final String username;

  @override
  String toString() => "Telegram";
}

class Website extends Contact with OnTapMixin {
  const Website({required this.url});

  final String url;

  @override
  String toString() => url.split('//').last;
}
