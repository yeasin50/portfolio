part of responsive;

class MaxWidthContainer extends StatelessWidget {
  final Widget child;

  const MaxWidthContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: kMaxWidth,
      ),
      child: child,
    );
  }
}
