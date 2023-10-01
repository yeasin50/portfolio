import 'dart:convert';

import 'package:about/src/features/core/models/about_data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  group('AboutPageData', () {
    final data = fixture('about_data.json');

    test('should be able to parse json', () {
      final map = jsonDecode(data) ;
      final AboutPageData aboutPageData = AboutPageData.fromMap(map);
      expect(aboutPageData, isA<AboutPageData>());
    });
  });
}
