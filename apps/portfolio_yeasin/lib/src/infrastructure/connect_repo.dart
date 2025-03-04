import 'package:effects/effects.dart' as eff;

class PreferenceData {
  const PreferenceData({
    required this.title,
    this.items = const [],
    this.description = "",
    this.type,
  });

  final String title;
  final List<String> items;
  final String description;

  final eff.BulletType? type;
}

///handle reason , way  of connecting
///* rules, preference, do's don't etc
///
class ConnectData {
  final String title = "Project connection";

  late List<PreferenceData> preferenceItems = [
    PreferenceData(
      title: "Tl;dr",
      description: tldr,
    ),
    PreferenceData(
      title: "This I work with",
      items: thingsIWorkWith,
      type: eff.BulletType.ok,
    ),
    PreferenceData(
      title: "My Work Philosophy: Values and Limitations",
      items: thingsIDontWorkWith,
      type: eff.BulletType.concern,
    ),
  ];

  final tldr =
      "I have worked on various types of projects for personal clients, companies, and government organizations throughout my development journey. Recents are under NDA, I will be happy if yours is not, but good ones are often lies here."
      " I often work as a part-time developer (20h/W) and take on additional contractual projects that require a few hours of maintenance each week."
      " The rest of the time, I enjoy learning new things and contributing on different platforms."
      " I also enjoy bug hunting and refactoring Flutter projects."
      " You will find me efficient in Flutter application development."
      " I prioritize working on ethical projects that align with my values and avoid anything that conflicts with my principles.";

  final thingsIWorkWith = [
    // **Flutter & Application Development**
    "My expertise shines in the Flutter framework, as I spend most of my time working with it.",
    "GoRouter is my go-to choice for routing.",
    "I prefer ThemeExtension over a static theme class.",
    "I like code generation but prefer writing small cases manually (e.g., JSON, ThemeExtension).",
    "I love animations. Yes, I have created many cool animations in Flutter, but for heavy character level computation, I use Rive.",

    // **Backend Development**
    "For backend solutions, I work with Firebase, Supabase, and Serverpod. If you have a backend developer, any backend solution is fine—whether it's REST, GraphQL, or WebSocket.",
    "I have been using Golang with PostgreSQL as a database since last year, but I am still in the learning phase for backend development.",
    "I use FVM Flutter SDK and Docker for backend development consistency.",

    // **State Management**
    "As for state management, I prefer Bloc. Riverpod, Provider, or built-in solutions are fine. Please don’t invite me to a project using GetX.",
    "For SDK or concern separation, I use InheritedWidget or just Stream—yes, Stream works well as a state management solution for mid-level projects.",

    // **Dependencies & Architecture**
    "I prefer adding fewer dependencies and only those that are well known (not by popularity/likes but understood, performance, and well-maintained).",
    "For large projects, I prefer a mono-repo pattern with Melos. However, this is usually unnecessary for most applications if the project is well-planned. Otherwise, I prefer a simple architecture based on dependencies, separating domain, presentation, and infrastructure (especially for mid-to-large applications).",

    // **Version Control & CI/CD**
    "Git for version, task, issue control, and code reviews.",
    "I prefer CI/CD tools like Git, Bristi-CLI, Code-Magic for building or deployment. Otherwise, I use a makefile to make life easier.",
    "I like writing only unit tests but often face issues with rapid changes that break things. Usually, organizations/clients don't provide enough time/requirements to write unit/widget tests often for rapid development and feature changes.",

    // **Documentation**
    "For documentation generation, I prefer using dartdoc. This has become my coding style. Notion doesn't feel like home yet.",

    // **Development Environment**
    "I use Windows as my primary workstation and Debian on my laptop. VS Code is my primary editor, and nowadays, I try NeoVim outside my workspace.",

    // **Communication**
    "For casual communication, Telegram is okay. For team collaboration, Slack feels better. Microsoft Teams? A very confusing experience.",
    "For task management, GitHub Issues/Projects, Jira, and Trello work fine, but I’m still not comfortable using Notion for task tracking. Don't tell me you still use Excel sheets for task management.",

    // **Philosophy & Learning**
    "My philosophy on writing code is to make it understandable by humans—including non-programmers.",
    "I prefer tasks to be clearly prioritized based on business impact and like to break large tasks into smaller, manageable pieces.",
    "I’m always eager to learn new technologies and basic computing (80's), often dedicating personal time to explore emerging trends. But I am not interested in learning low performant tech despite being popularity, PHP or Python for backend; I am interested in Rust and have a future goal in it.",
    "I love programming over drag-and-drop development.",
    "I prefer an effective coding style and material design (Currently investing time in UX as well)."
  ];

  final List<String> thingsIDontWorkWith = [
    // Ethical Concerns
    "Projects that involve unethical hacking, illegal activities, or deceptive business models (e.g., pyramid schemes, get-rich-quick apps)",
    "Projects that violate privacy, security, or ethical guidelines",
    "Projects that violate Google Play or App Store policies",

    // Personal and Cultural Values
    "E-commerce or services related to haram products (e.g., bars, alcoholic drinks, tattoos, adult content, etc.)",
    "Teams or organizations where I will face pronoun issues (e.g., they/them)",

    // Industry and Type of Work
    "Any type of gambling or dating applications",
    "Crypto or NFT projects",

    // Work Environment
    "Toxic company culture or excessive workplace politics",
    "Clients looking for low-budget developers",
    "Companies that demand unrealistic deadlines with unfair compensation",
    "Micromanaging clients who don’t trust developers",

    // Scope, Documentation, and Clarity
    "Projects that lack clear vision, proper documentation, or realistic expectations",
    "Projects with a poorly defined or constantly changing scope",
    "Unpaid trial work or 'test tasks' before hiring",

    // Payment and Compensation
    "Equity-only payment models with no guaranteed compensation",
    "Clients who expect endless revisions without extra pay",

    // Client Relations
    "Non-technical clients who refuse to listen to expert advice",

    // Legal and Contractual Concerns
    "Excessive NDA or contract restrictions limiting future work (while I’m open to reasonable NDAs for sensitive projects)",

    // Fake or Deceptive Projects
    "Spam, fake engagement, or deceptive marketing projects",

    // Work Hours Preference
    "Not interested in full-time work exceeding 35 hours per week"
  ];
}
