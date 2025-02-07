class Organization {
  const Organization({
    required this.name,
    this.logoUrl,
    this.websiteUrl,
    this.description,
  });

  final String name;
  final String? logoUrl;
  final String? websiteUrl;
  final String? description;

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      name: map['name'] ?? '',
      logoUrl: map['logo_url'],
      websiteUrl: map['website_url'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return 'Organization(name: $name, logoUrl: $logoUrl, websiteUrl: $websiteUrl, description: $description)';
  }
}
