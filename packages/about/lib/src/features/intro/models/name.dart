import 'dart:convert';

class Name {
  const Name({
    required this.first,
    this.middle,
    required this.last,
  });

  final String first;
  final String? middle;
  final String last;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'first': first});
    if (middle != null) {
      result.addAll({'middle': middle});
    }
    result.addAll({'last': last});

    return result;
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      first: map['first'] ?? '',
      middle: map['middle'],
      last: map['last'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) => Name.fromMap(json.decode(source));

  @override
  String toString() {
    return "$first${middle == null ? ' ' : " $middle "}$last";
  }
}
