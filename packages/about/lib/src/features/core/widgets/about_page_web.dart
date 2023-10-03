part of 'about_page.dart';

class AboutWebView extends StatelessWidget {
  const AboutWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = AboutDataProvider.of(context)!.data;
    return Align(
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
            ExpRow(),
          ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EducationView(educations: data.educations),
        ExperienceView(experiences: data.experiences),
        CertificateView(certificates: data.certificates),
        // SkillView(skill: skills[0]),
        // SkillView(skill: skills[1]),
      ],
    );
  }
}
