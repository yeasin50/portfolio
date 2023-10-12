import 'dart:convert';

import '../../common/models/organization.dart';

class Certificate {
  const Certificate({
    required this.name,
    required this.organization,
    this.credentialUrl,
    this.imageUrl,
    this.description,
    this.issueDate,
    this.expirationDate,
  });

  final String name;
  final Organization organization;
  final String? credentialUrl;
  final String? imageUrl;
  final String? description;

  final DateTime? issueDate;
  final DateTime? expirationDate;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'organization': organization.toMap()});
    if (credentialUrl != null) {
      result.addAll({'credentialUrl': credentialUrl});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
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

  factory Certificate.fromMap(Map<String, dynamic> map) {
    return Certificate(
      name: map['name'] ?? '',
      organization: Organization.fromMap(map['organization']),
      credentialUrl: map['credentialUrl'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      issueDate: map['issueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['issueDate'])
          : null,
      expirationDate: map['expirationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expirationDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Certificate.fromJson(String source) =>
      Certificate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Certificate(name: $name, organization: $organization, credentialUrl: $credentialUrl, imageUrl: $imageUrl, description: $description, issueDate: $issueDate, expirationDate: $expirationDate)';
  }
}
