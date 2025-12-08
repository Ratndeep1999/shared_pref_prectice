class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.appbarTitle});

  final String appbarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: LabelTextWidget(label: appbarTitle),
      centerTitle: true,
      backgroundColor: Colors.purple,
    );
  }
}
