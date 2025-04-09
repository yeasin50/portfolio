import 'package:core/core.dart';
import 'package:experience/experience.dart';

class UserInfoResponse {
  const UserInfoResponse({
    required this.version,
    required this.updatedAt,
    required this.into,
    required this.connects,
    required this.experience,
    required this.education,
    required this.certificates,
  });

  final int version;
  final DateTime updatedAt;
  final IntroInfo into;
  final List<Connect> connects;
  final List<Experience> experience;
  final List<Education> education;
  final List<Certificate> certificates;

  static UserInfoResponse fromMap(Map<String, dynamic> map) {
    return UserInfoResponse(
      version: map["version"],
      updatedAt: DateTime.tryParse(map["updated_at"]) ?? DateTime.now(),
      into: IntroInfo.fromMap(map["intro"]),
      connects:
          List.from(map["connects"]?.map((e) => Connect.fromMap(e)) ?? []),
      experience:
          List.from(map["experience"]?.map((e) => Experience.fromMap(e)) ?? []),
      education:
          List.from(map["education"]?.map((e) => Education.fromMap(e)) ?? []),
      certificates: List.from(
          map["certificate"]?.map((e) => Certificate.fromMap(e)) ?? []),
    );
  }

  @override
  String toString() {
    return 'UserInfoResponse(version: $version, updatedAt: $updatedAt, into: $into, connects: $connects, experience: $experience, education: $education, certificates: $certificates)';
  }
}
