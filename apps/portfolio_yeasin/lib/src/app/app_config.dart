class AppConfig {
  const AppConfig({required this.baseUrl});

  static const AppConfig dev = AppConfig(baseUrl: "http://localhost:8080");

  final String baseUrl;
}
