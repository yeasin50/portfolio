class GeneralResponse<T> {
  const GeneralResponse({
    required this.version,
    required this.updatedAt,
    required this.data,
  });

  final int version;
  final DateTime updatedAt;
  final List<T> data;

  factory GeneralResponse.fromMap(
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromMapT,
  ) {
    final map = data["data"];
    return GeneralResponse<T>(
      version: map["version"] as int,
      updatedAt: DateTime.parse(map["updated_at"]),
      data: (map["data"] as List<dynamic>).map((e) => fromMapT(e)).toList(),
    );
  }
}
