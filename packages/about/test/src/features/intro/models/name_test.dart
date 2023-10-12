import 'package:about/src/features/intro/intro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Name', () {
    group('toString()', () {
      test(
        'Should handle empty middle name',
        () {
          const name = Name(
            first: 'Md. Yeasin',
            last: 'Sheikh',
          );
          expect(name.toString(), 'Md. Yeasin Sheikh');
        },
      );

      test('return return middle name by maintaining space', () {
        const name = Name(
          first: 'Md.',
          middle: 'Yeasin',
          last: 'Sheikh',
        );
        expect(name.toString(), 'Md. Yeasin Sheikh');
      });
    });
  });
}
