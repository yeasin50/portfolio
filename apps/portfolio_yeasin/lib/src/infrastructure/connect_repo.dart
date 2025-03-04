import 'package:effects/effects.dart' as eff;

class PreferenceData {
  const PreferenceData({
    required this.title,
    this.items = const {},
    this.description = "",
    this.type,
  });

  final String title;
  // well could use dynamic but anyway
  final Map<String, List<String>> items;
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
      title: "Workstyle & Preferences",
      items: personalWorkingPreferences,
      type: eff.BulletType.unListed,
    ),
    PreferenceData(
      title: "Things I Work With",
      items: thingsIWorkWith,
      type: eff.BulletType.ok,
    ),
    PreferenceData(
      title: "My Work Philosophy: Values and Limitations",
      items: thingsIDontWorkWith,
      type: eff.BulletType.cross,
    ),
  ];

  final tldr =
      "I have worked on various types of projects for personal clients, companies, and government organizations throughout my development journey. Recents are under NDA, I will be happy if yours is not, but good ones are often lies here."
      " I often work as a part-time developer (20h/W) and take on additional contractual projects that require a few hours of maintenance each week."
      " The rest of the time, I enjoy learning new things and contributing on different platforms."
      " I also enjoy bug hunting and refactoring Flutter projects."
      " You will find me efficient in Flutter application development."
      " I prioritize working on ethical projects that align with my values and avoid anything that conflicts with my principles.";

  final Map<String, List<String>> thingsIWorkWith = {
    'Flutter & Application Development': [
      "My expertise shines in the Flutter framework, as I spend most of my time working with it.",
      "GoRouter is my go-to choice for routing.",
      "I prefer ThemeExtension over a static theme class.",
      "I like code generation but prefer writing small cases manually (e.g., JSON, ThemeExtension).",
      "I love animations. Yes, I have created many cool animations in Flutter, but for heavy character level computation, I use Rive."
    ],
    'Backend Development': [
      "For backend solutions, I work with Firebase, Supabase, and Serverpod. If you have a backend developer, any backend solution is fine—whether it's REST, GraphQL, or WebSocket.",
      "I have been using Golang with PostgreSQL as a database since last year, but I am still in the learning phase for backend development.",
      "I use FVM Flutter SDK and Docker for backend development consistency."
    ],
    'State Management': [
      "As for state management, I prefer Bloc. Riverpod, Provider, or built-in solutions are fine. Please don’t invite me to a project using GetX.",
      "For SDK or concern separation, I use InheritedWidget or just Stream—yes, Stream works well as a state management solution for mid-level projects."
    ],
    'Dependencies & Architecture': [
      "I prefer adding fewer dependencies and only those that are well known (not by popularity/likes but understood, performance, and well-maintained).",
      "For large projects, I prefer a mono-repo pattern with Melos. However, this is usually unnecessary for most applications if the project is well-planned. Otherwise, I prefer a simple architecture based on dependencies, separating domain, presentation, and infrastructure (especially for mid-to-large applications)."
    ],
    'Version Control & CI/CD': [
      "Git for version, task, issue control, and code reviews.",
      "I prefer CI/CD tools like Git, Bristi-CLI, Code-Magic for building or deployment. Otherwise, I use a makefile to make life easier.",
      "I like writing only unit tests but often face issues with rapid changes that break things. Usually, organizations/clients don't provide enough time/requirements to write unit/widget tests often for rapid development and feature changes."
    ],
    'Documentation': [
      "For documentation generation, I prefer using dartdoc. This has become my coding style. Notion doesn't feel like home yet."
    ],
    'Development Environment': [
      "I use Windows as my primary workstation and Debian on my laptop. VS Code is my primary editor, and nowadays, I try NeoVim outside my workspace."
    ],
    'Communication': [
      "For casual communication, Telegram is okay. For team collaboration, Slack feels better. Microsoft Teams? A very confusing experience.",
      "For task management, GitHub Issues/Projects, Jira, and Trello work fine, but I’m still not comfortable using Notion for task tracking. Don't tell me you still use Excel sheets for task management."
    ],
    'Philosophy & Learning': [
      "My philosophy on writing code is to make it understandable by humans—including non-programmers.",
      "I prefer tasks to be clearly prioritized based on business impact and like to break large tasks into smaller, manageable pieces.",
      "I’m always eager to learn new technologies and basic computing (80's), often dedicating personal time to explore emerging trends. But I am not interested in learning low performant tech despite being popular, PHP or Python for backend; I am interested in Rust and have a future goal in it.",
      "I love programming over drag-and-drop development.",
      "I prefer an effective coding style and material design (Currently investing time in UX as well)."
    ]
  };

  final Map<String, List<String>> thingsIDontWorkWith = {
    "": [
      "Projects that involve unethical hacking, illegal activities, or deceptive business models (e.g., pyramid schemes, get-rich-quick apps)",
      "Projects that violate privacy, security, or ethical guidelines",
      "Projects that violate Google Play or App Store policies",
      "E-commerce or services related to haram products (e.g., bars, alcoholic drinks, tattoos, adult content, etc.)",
      "Teams or organizations where I will face pronoun issues (e.g., they/them)",
      "Any type of gambling or dating applications",
      "Crypto or NFT projects",
      "Toxic company culture or excessive workplace politics",
      "Clients looking for low-budget developers",
      "Companies that demand unrealistic deadlines with unfair compensation",
      "Micromanaging clients who don’t trust developers",
      "Projects that lack clear vision, proper documentation, or realistic expectations",
      "Projects with a poorly defined or constantly changing scope",
      "Unpaid trial work or 'test tasks' before hiring",
      "Equity-only payment models with no guaranteed compensation",
      "Clients who expect endless revisions without extra pay",
      "Non-technical clients who refuse to listen to expert advice",
      "Excessive NDA or contract restrictions limiting future work (while I’m open to reasonable NDAs for sensitive projects)",
      "Spam, fake engagement, or deceptive marketing projects",
      "Not interested in full-time work exceeding 35 hours per week"
    ]
  };

  final Map<String, List<String>> personalWorkingPreferences = {
    "Work Environment & Attire": [
      "I'm a casual person, and you’ll find me at meetings in my usual outfit, whether it's a meeting or an event.",
      "If there’s a specific dress code, I'm not a fan of it and prefer a more relaxed approach to dressing for work.",
    ],

    "Workspace & Productivity": [
      "I’m used to working on a large table (well, two tables—one for my CPU, books, and drinks).",
      "I use three monitors (all >22'' FHD), a whiteboard, and various accessories to keep me productive, including food.",
      "Working in a typical office environment isn’t ideal for my efficiency unless the setup can match my needs. If you can provide me with the right facilities, I'd be happy to work in-office.",
      "I prefer to have a private space where I can focus and work alone to stay productive.",
    ],

    // Distractions & Focus
    "Work Environment & Distractions": [
      "I often leave my phone while working, and it stays on vibration mode with notifications turned off.",
      "I also avoid keeping extra software or browser tabs open that could distract me.",
      "If you need to call me, please schedule it in advance unless it's a scheduled job. This helps maintain my focus and efficiency.",
      "Once we agree on a schedule, I’d appreciate it if we could stick to it without delays or postponements to avoid impacting productivity.",
    ],

    // Meetings & Communication
    "Meetings & Communication": [
      "If something can be covered in a short message, please avoid scheduling a meeting.",
      "I’ve noticed that some meetings are scheduled just to input non-technical tasks, often for upper management who may prioritize compliance over actual work or value.",
    ],

    // Task Management & Bugs
    "Bug Fixing & Task Management": [
      "As a bug hunter, I tend to fix every issue I come across during the project.",
      "If there are many tracked or untracked issues, please guide me on which ones to focus on and confirm (via call) whether I’ve fully understood the task.",
      "In large, messy projects with many issues, I may not be highly efficient during the initial days as I familiarize myself with the existing codebase.",
    ],

    // Time Management & Deadlines
    "Time Estimation & Deadlines": [
      "I'm not great at time estimation as I tend to seek perfection in my work. So, it’s helpful if you can provide clear guidelines on how much time I should spend on a task and set a deadline for each sprint or milestone.",
    ],

    // Work Schedule
    "Work Schedule & Productivity": [
      "Unlike a typical human schedule, my working hours are a bit unconventional. I tend to keep working until I'm satisfied with the result or until my body can no longer handle it.",
      "I can work with a schedule, but I prefer working from 3 AM to midday, leaving the evening (around 10 PM) open for meetings and other commitments.",
      "Planning, brainstorming, and thinking tasks are often best done early in the morning during sunrise time for me, before I dive into coding.",
    ],

    // Non-Tech Events
    "Non-Tech Events": [
      "In an organization, I prefer not to attend non-technical events or personal life events of senior employees unless necessary for the project or team dynamics.",
    ],
  };
}
