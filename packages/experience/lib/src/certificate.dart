import 'dart:convert';

import 'package:core/core.dart';

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

  factory Certificate.fromMap(Map<String, dynamic> map) {
    return Certificate(
      name: map['name'] ?? '',
      organization: Organization.fromMap(map['organization']),
      credentialUrl: map['credential_url'],
      imageUrl: map['image_url'],
      description: map['description'],
      issueDate:
          map['issue_date'] != null ? DateTime.parse(map['issue_date']) : null,
      expirationDate: map['expiration_date'] != null
          ? DateTime.parse(map['expiration_date'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Certificate(name: $name, organization: $organization, credentialUrl: $credentialUrl, imageUrl: $imageUrl, description: $description, issueDate: $issueDate, expirationDate: $expirationDate)';
  }
}
