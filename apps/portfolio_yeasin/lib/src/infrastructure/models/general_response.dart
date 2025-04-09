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
    final map = data["data"] as List;
    return GeneralResponse<T>(
      version: data["version"],
      updatedAt: DateTime.parse(data["updated_at"]),
      data: map.map((e) => fromMapT(e)).toList(),
    );
  }
}
