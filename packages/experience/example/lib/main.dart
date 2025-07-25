import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        extensions: [
          ExperienceTheme.darkTheme(),
          // ExperienceTheme.dayTheme(),
        ],
      ),
      home: _Home(),
    ),
  );
}

class _Home extends StatefulWidget {
  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final items = List.generate(
    5,
    (index) => Experience(
      title: "Flutter Developer",
      organization: Organization(name: "organization"),
      start: DateTime(2020),
      description:
          "Created x with boost performance 20% which increased revenue \$12B",
    ),
  );

  final educations = [
    Education(
      school: Organization(
        name: "Daffodil International University",
      ),
      degree: "Bachelor",
      field: "Computer Science and Engineering",
      start: DateTime(2018, 01),
      end: DateTime(2023, 09),
      grade: "3.67 out of 4.0",
      description: "this is a long description" * 23,
    ),
    Education(
      school: Organization(
        name: "Daffodil International University",
      ),
      degree: "Bachelor",
      field: "Computer Science and Engineering",
      start: DateTime(2018, 01),
      end: DateTime(2023, 09),
      grade: "3.67 out of 4.0",
      description: "this is a long description" * 23,
    ),
  ];

  final certificates = [
    Certificate(
      name: "Certified in FlutterDevcamp State Management",
      organization: Organization(
        name: "Google Developer Group, London",
      ),
      issueDate: DateTime(2023),
    ),
    ...List.filled(
      4,
      Certificate(
          name: "Foundation of User Experience(UX) Designed",
          organization: Organization(
            name: "Google",
          ),
          issueDate: DateTime(2023),
          description: "desc " * 22),
    ),
    Certificate(
      name:
          "Completed the Microsoft Asia Virtual Experience Program in Engineering(Undergraduate & Masters)",
      organization: Organization(name: "Microsoft"),
      issueDate: DateTime(2021),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 32,
        children: [
          CertificateListView(certificates: certificates),
          ExperienceView(experiences: items),
          Text("some text"),
          // EducationItemsView(educations: educations),
        ],
      ),
    );
  }
}
