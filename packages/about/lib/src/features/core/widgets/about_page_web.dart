part of 'about_page.dart';

class AboutWebView extends StatelessWidget {
  const AboutWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AboutDataProvider.of(context)!.data;
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: MaxWidthContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NetworkImageBuilder(
                    imageUrl: data.description.imageUrl,
                    hash: data.description.imageHash,
                  ),
                  24.horizontalSpacer,
                  Expanded(
                    child: IntroView(
                      name: data.name,
                      description: data.description,
                    ),
                  )
                ],
              ),
              24.verticalSpacer,
              const Divider(thickness: 2),
              const ExpRow(),
              const Divider(thickness: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpRow extends StatelessWidget {
  const ExpRow({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AboutDataProvider.of(context)!.data;
    final skills = data.skills;

    final count = switch (Responsive.screenType) {
      ScreenType.mobile => 1,
      ScreenType.tablet => 3,
      _ => 4,
    };

    final widgets = [
      EducationView(educations: data.educations),
      ExperienceView(experiences: data.experiences),
      CertificateView(certificates: data.certificates),
      ...skills.map((e) => SkillView(skill: e)),
    ]
        .map(
          (e) => Container(
            padding: const EdgeInsets.all(16),
            width: Responsive.size.width / count,
            child: e,
          ),
        )
        .toList();

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          ...widgets,
        ],
      ),
    );
  }
}
