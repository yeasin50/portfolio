part of 'api_service.dart';

class ApiConfig {
  final String baseUrl;

  ///  the place it contains media files,
  /// it has `low_res` and `high_res` folder
  final String imageDir;

  final String iconDir;

  final Duration timeout;
  final Logger logger;

  const ApiConfig({
    required this.baseUrl,
    required this.imageDir,
    required this.iconDir,
    this.timeout = const Duration(seconds: 30),
    required this.logger,
  });

  static ApiConfig dev = ApiConfig(
    baseUrl: "http://localhost:8080",
    imageDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/server/database/images/",
    iconDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/server/database/logo/",
    logger: Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        colors: true,
        printEmojis: true,
      ),
    ),
  );

  static ApiConfig prod = ApiConfig(
    baseUrl:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/master/server/database/json/",
    imageDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/master/server/database/images/",
    iconDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/master/server/database/logo/",
    logger: Logger(),
  );

  bool get isDev => baseUrl.contains("localhost");
  bool get isGitProd => baseUrl.contains("githubusercontent");
}
