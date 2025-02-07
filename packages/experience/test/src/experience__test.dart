import 'package:experience/experience.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('experience  parse ...', () {
    const jsonData = r'''{
      "title": "Software Engineer",
      "organization": {
        "name": "Upwork"
      },
      "start": "2021-07-01T00:00:00Z",
      "end": null,
      "description": "Freelance hybrid developer with extensive experience in bringing creative ideas to life. Led multiple projects, including DataHub for Daffodil Health Department, and worked on a variety of Flutter-based applications."
    }
    ''';

    final result = Experience.fromJson(jsonData);
    expect(result, isA<Experience>());
  });
}
