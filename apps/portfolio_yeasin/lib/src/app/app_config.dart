class AppConfig {
  const AppConfig._({
    required this.baseUrl,
    required this.imageDir,
    required this.iconDir,
  });

  /// the base uri;
  /// if it is github, the path will just append rather than replace
  ///
  final String baseUrl;

  ///  the place it contains media files,
  /// it has `low_res` and `high_res` folder
  final String imageDir;

  final String iconDir;

  static const AppConfig dev = AppConfig._(
    baseUrl: "http://localhost:8080",
    imageDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/server/database/images/",
    iconDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/dev/server/database/logo/",
  );

  static const AppConfig gitProd = AppConfig._(
    baseUrl:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/master/server/database/json/",
    imageDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/master/server/database/images/",
    iconDir:
        "https://raw.githubusercontent.com/yeasin50/portfolio/refs/heads/master/server/database/logo/",
  );

  bool get isDev => baseUrl.contains("localhost");
  bool get isGitProd => baseUrl.contains("githubusercontent");
}
