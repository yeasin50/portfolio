import 'dart:convert';

import 'package:time_machine2/time_machine2.dart' as tz;
import 'package:http/http.dart' as http;
import '../sun_scheduler.dart';
import 'routine_info.dart';

abstract class ISunScheduler {
  RoutineParser? get data;

  /// user can convert into theses zone
  List<tz.DateTimeZone> get availableZone;

  Future<void> init({required Uri uri, required tz.DateTimeZone zone});

  /// convert author's routine into  [zone] format
  RoutineParser? of(tz.DateTimeZone zone);
}

class RoutineRepo extends ISunScheduler {
  tz.DateTimeZone selectedTimeZone = tz.DateTimeZone.local;

  List<tz.DateTimeZone> _zoneProvider = [];
  RoutineParser? _autherRoutine;
  RoutineParser? _viwerRoutine;

  @override
  List<tz.DateTimeZone> get availableZone => [..._zoneProvider];

  @override
  RoutineParser? get data => _viwerRoutine;

  @override
  Future<void> init({required Uri uri, required tz.DateTimeZone zone}) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw "Unable to reach server";
      }

      final map = jsonDecode(response.body);
      _autherRoutine = RoutineParser.fromMap(map);
      of(selectedTimeZone);
    } catch (e) {
      ///
      throw "failed to parse routine data ${e.toString()}";
    }
  }

  @override
  RoutineParser? of(tz.DateTimeZone zone) {
    if (_autherRoutine == null) {
      throw "auther data is missing or haven't initiized yet. call `init(...)`";
    }

    final routines = _autherRoutine!.routines;
    List<RoutineInfo> result = [];
    for (final r in routines) {
      for (final e in r.entities) {
        // if duration is not null
        // need to get the event's days from another api and connect them

        // if slot is not empty
      }
    }

    return _viwerRoutine;
  }
}
