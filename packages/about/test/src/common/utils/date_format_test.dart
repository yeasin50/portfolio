import 'package:about/src/features/common/utils/date_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('experienceDateFormat', () {
    final start = DateTime(2020, 1, 1);
    final end = DateTime(2020, 2, 1);

    test('should return correct format when end is null', () {
      final result = experienceDateFormat(start, null);
      expect(result, 'Jan 2020 - Present');
    });

    test('should return correct format when end is not null', () {
      final result = experienceDateFormat(start, end);
      expect(result, 'Jan 2020 - Feb 2020');
    });
  });
}
