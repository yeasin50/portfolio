import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sun_scheduler/src/route_parser.dart';
import 'package:sun_scheduler/src/routine_info.dart';

import 'package:sun_scheduler/sun_scheduler.dart';

import 'fixture.dart';

void main() {
  test('parse timeSlot', () {
    final data = {
      "05:00 am": TimeOfDay(hour: 5, minute: 0),
      "05:00 pm": TimeOfDay(hour: 12 + 5, minute: 0),
      "9:40 am": TimeOfDay(hour: 9, minute: 40),
    };
    for (final d in data.entries) {
      final result = TimeSlot.parseTimeOfDay(d.key);
      expect(result, d.value);
    }
  });

  test("TimeSLot from  map", () {
    final map = {"start_work": "05:00 am", "end_work": "08:00 am"};

    final result = TimeSlot.fromMap(map);
    expect(result.start, TimeOfDay(hour: 5, minute: 0));
    expect(result.end, TimeOfDay(hour: 8, minute: 0));
  });

  test("should pass when  we have valid data for entityRow", () {
    final data = MapEntry("Saturday", [
      {"start_work": "05:00 am", "end_work": "08:00 am"},
    ]);

    final result = EntityRow.fromMap(data);
    expect(result.slot, isA<List<TimeSlot>>());
    expect(result.duration, null);
  });

  test("parse Entity Data from  json", () {
    final jsonString = fixture("test_data.json");

    final jsonData = jsonDecode(jsonString)["data"];

    for (final data in jsonData) {
      final r = RoutineInfo.fromMap(data);
    }
  });

}
