import 'dart:convert';

import 'package:experience/experience.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('certificate  parse ...', () {
    const jsonData = r''' {
      "name": "FlutterDevcamp State Management Special",
      "organization": {
        "name": "GDG London"
      },
      "credential_url": null,
      "image_url": null,
      "issue_date": "2023-09-01T00:00:00Z",
      "expiration_date": null
    }
    ''';

    final result = Certificate.fromMap(jsonDecode(jsonData));
    expect(result, isA<Certificate>());
  });
}
