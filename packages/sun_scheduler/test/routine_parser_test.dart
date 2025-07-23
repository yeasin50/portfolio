import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sun_scheduler/sun_scheduler.dart';

import 'fixture.dart';

void main() {
  test("Routine parser should throw exception  when  dateTime is missing", () {
    final map = {"version": 0, "data": []};

    try {
      final result = RouteParser.fromMap(map);
      fail("expect an exception");
    } catch (e) {
      final msg = e.toString();
      expect(msg.isNotEmpty, true, reason: "without update_at it should fail");
    }
  });

  test("RoutineParser should pass with valid data", () {
    final data = fixture("test_data.json");

    try {
      final result = RouteParser.fromMap(jsonDecode(data));
      expect(result, isA<RouteParser>());
    } catch (e) {
      fail("should not fail ${e.toString()}");
    }
  });
}
