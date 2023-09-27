import 'dart:convert';

import '../../common/models/organization.dart';

class Certification {
  const Certification({
    required this.name,
    required this.organization,
    this.credentialId,
    this.description,
    this.issueDate,
    this.expirationDate,
  });

  final String name;
  final Organization organization;
  final String? credentialId;
  final String? description;

  final DateTime? issueDate;
  final DateTime? expirationDate;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'organization': organization.toMap()});
    if (credentialId != null) {
      result.addAll({'credentialId': credentialId});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (issueDate != null) {
      result.addAll({'issueDate': issueDate!.millisecondsSinceEpoch});
    }
    if (expirationDate != null) {
      result.addAll({'expirationDate': expirationDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      name: map['name'] ?? '',
      organization: Organization.fromMap(map['organization']),
      credentialId: map['credentialId'],
      description: map['description'],
      issueDate: map['issueDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['issueDate']) : null,
      expirationDate: map['expirationDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['expirationDate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Certification.fromJson(String source) => Certification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Certification(name: $name, organization: ${organization.toString()}, credentialId: $credentialId, description: $description, issueDate: $issueDate, expirationDate: $expirationDate)';
  }
}
