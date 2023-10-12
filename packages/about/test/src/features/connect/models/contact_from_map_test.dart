import 'dart:convert';

import 'package:about/about.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  group('contact_from_map', () {
    group('fromMapEntry', () {
      test('should return PhoneContact', () {
        const MapEntry entry = MapEntry('phone', '0101');
        expect(fromMapEntry(entry), isA<PhoneContact>());
      });

      test('should return Email', () {
        const MapEntry entry = MapEntry('email', '');
        expect(fromMapEntry(entry), isA<Email>());
      });

      test('should return Address', () {
        const MapEntry entry = MapEntry('address', '');
        expect(fromMapEntry(entry), isA<Address>());
      });

      test('should return LinkedIn', () {
        const MapEntry entry = MapEntry('linkedin', '');
        expect(fromMapEntry(entry), isA<LinkedIn>());
      });

      test('should return Telegram', () {
        const MapEntry entry = MapEntry('telegram', '');
        expect(fromMapEntry(entry), isA<Telegram>());
      });

      test('should return Website', () {
        const MapEntry entry = MapEntry('website', '');
        expect(fromMapEntry(entry), isA<Website>());
      });

      test('should return Twitter', () {
        const MapEntry entry = MapEntry('twitter', '');
        expect(fromMapEntry(entry), isA<Twitter>());
      });

      test('should return Youtube', () {
        const MapEntry entry = MapEntry('youtube', '');
        expect(fromMapEntry(entry), isA<Youtube>());
      });

      test('should return Medium', () {
        const MapEntry entry = MapEntry('medium', '');
        expect(fromMapEntry(entry), isA<Medium>());
      });

      test('should return OtherSite', () {
        const MapEntry entry = MapEntry(
          'other',
          {
            "name": "Yeasin Sheikh",
            "url": "https://yeasinsheikh",
            "data": "what is this?"
          },
        );
        expect(fromMapEntry(entry), isA<OtherSite>());
      });
    });

    group('contactFromJson', () {
      test('should return a list of Contact', () {
        final json = fixture('connect.json');
        final data = jsonDecode(json);
        final result = contactFromJson(data);
        expect(result, isA<List<Contact>>());
        expect(result.length, 12);
      });
    });
  });
}
