import 'routine_info.dart';

/// Author routine
class RoutineParser {
  const RoutineParser({
    required this.version,
    required this.updatedAt,
    required this.routines,
  });

  final int version;

  /// must be provided on UTC format of author location.
  final DateTime updatedAt;
  final List<RoutineInfo> routines;

  factory RoutineParser.fromMap(Map<String, dynamic> map) {
    if (map["updated_at"] == null) throw "updated_at can not be null";

    if (map["data"] is! List) throw "data must be a list";
    return RoutineParser(
      version: int.tryParse("${map["version"]}") ?? 0,
      updatedAt: DateTime.parse(map["updated_at"]),
      routines: List.from(map["data"].map((e) => RoutineInfo.fromMap(e))),
    );
  }
}
