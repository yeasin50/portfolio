///  basic info will be used for the user
/// ```dart
/// const IntroInfo(
///     name: "Md. Yeasin Sheikh",
///     title: "Software Developer | Flutter specialist",
///     shortTitle: "SDE | Flutter",
///   );
///```
class IntroInfo {
  const IntroInfo({
    required this.name,
    required this.title,
    required this.shortTitle,
    required this.description,
  });

  final String name;
  final String title;
  final String shortTitle;
  final String description;

  static IntroInfo fromMap(Map<String, dynamic> map) {
    return IntroInfo(
      name: map["name"],
      title: map["title"],
      shortTitle: map["short_title"],
      description: map["description"],
    );
  }

  static IntroInfo none({String? msg}) => IntroInfo(
        name: "404",
        title: "failed to fetch",
        shortTitle: "",
        description: msg ?? "Check  api end points or perse",
      );

  @override
  String toString() {
    return 'IntroInfo(name: $name, title: $title, shortTitle: $shortTitle, description: $description)';
  }
}
