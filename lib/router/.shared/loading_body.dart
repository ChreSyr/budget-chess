// TODO : LoadingBody, LoadingBody.deletingAccount

class CreatingAccountPage extends RouteBody {
  const CreatingAccountPage({super.key});

  @override
  List<Widget> getActions(BuildContext context) =>
      getEmergencyAppBarActions(context);

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Creating your account'),
          CCGap.small,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class LoadingAccountPage extends RouteBody {
  const LoadingAccountPage({super.key});

  @override
  List<Widget> getActions(BuildContext context) =>
      getEmergencyAppBarActions(context);

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Loading your account'),
          CCGap.small,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class DeletingAccountPage extends RouteBody {
  const DeletingAccountPage({super.key});

  @override
  List<Widget> getActions(BuildContext context) => [];

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Deleting your account'),
          CCGap.small,
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
