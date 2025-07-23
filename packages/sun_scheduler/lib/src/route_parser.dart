import 'package:time_machine2/time_machine2.dart' as tz;

import 'routine_info.dart';

abstract class ISunScheduler {

  RouteParser? get data;
  /// user can convert into theses zone
  List<tz.DateTimeZone> get availableZone;

  Future<RouteParser> init({required Uri uri, required tz.DateTimeZone zone});

  /// convert author's routine into  [zone] format
  RoutineInfo of(tz.DateTimeZone zone);
}

/// Author routine
class RouteParser {
  const RouteParser({
    required this.version,
    required this.updatedAt,
    required this.routines,
  });

  final int version;

  /// must be provided on UTC format of author location.
  final DateTime updatedAt;
  final List<RoutineInfo> routines;

  factory RouteParser.fromMap(Map<String, dynamic> map) {
    if (map["updated_at"] == null) throw "updated_at can not be null";

    if (map["data"] is! List) throw "data must be a list";
    return RouteParser(
      version: int.tryParse("${map["version"]}") ?? 0,
      updatedAt: DateTime.parse(map["updated_at"]),
      routines: List.from(map["data"].map((e) => RoutineInfo.fromMap(e))),
    );
  }
}
