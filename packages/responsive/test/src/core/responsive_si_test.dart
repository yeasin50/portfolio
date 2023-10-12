import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive/responsive.dart';

void main() {
  group('responsive_si', () {
    test('Responsive should be singleton class', () {
      expect(Responsive(), Responsive());
    });

    test("throw assert if the it doesn't init", () {
      expect(() => Responsive.screenType, throwsA(isA<AssertionError>()));
    });

    const mobileScreenSize = Size(600, 700);
    const tabletScreenSize = Size(800, 700);
    const desktopScreenSize = Size(1200, 700);

    group('ScreenType from context', () {
      Widget buildTestableWidget({required Widget widget, required Size screenSize}) {
        return MediaQuery(
          data: MediaQueryData(size: screenSize),
          child: MaterialApp(home: widget),
        );
      }

      testWidgets('should be return mobile when <=600', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            screenSize: mobileScreenSize,
            widget: Builder(
              builder: (context) {
                Responsive.init(context);
                expect(Responsive.screenType, ScreenType.mobile);
                return const Placeholder();
              },
            ),
          ),
        );
      });

      testWidgets('should be return tablet when <=1100', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            screenSize: tabletScreenSize,
            widget: Builder(
              builder: (context) {
                Responsive.init(context);
                expect(Responsive.screenType, ScreenType.tablet);
                return const Placeholder();
              },
            ),
          ),
        );
      });

      testWidgets('should be return desktop when >1100', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            screenSize: desktopScreenSize,
            widget: Builder(
              builder: (context) {
                Responsive.init(context);
                expect(Responsive.screenType, ScreenType.desktop);
                return const Placeholder();
              },
            ),
          ),
        );
      });
    });

    group('ScreenType from initWithSize', () {
      test('should be return mobile when <=600', () {
        Responsive.initWithSize(mobileScreenSize);
        expect(Responsive.screenType, ScreenType.mobile);
      });

      test('should be return tablet when <=1100', () {
        Responsive.initWithSize(tabletScreenSize);
        expect(Responsive.screenType, ScreenType.tablet);
      });

      test('should be return desktop when >1100', () {
        Responsive.initWithSize(desktopScreenSize);
        expect(Responsive.screenType, ScreenType.desktop);
      });
    });
  });
}
