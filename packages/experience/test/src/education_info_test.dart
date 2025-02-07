import 'package:experience/experience.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('education  parse ...', () {
    const jsonData = r'''{
      "school": {
        "name": "Daffodil International University"
      },
      "degree": "Bachelor",
      "field": "Computer Science and Engineering",
      "start": "2018-01-01T00:00:00Z",
      "end": "2023-09-01T00:00:00Z",
      "grade": "3.67 out of 4.0",
      "description": "Not that efficient for my limited lifespan",
      "images": []
    }
    ''';

    final result = Education.fromJson(jsonData);
    expect(result, isA<Education>());
  });
}
