import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessagesRoute extends CCRoute {
  const MessagesRoute._() : super(name: '/messages', icon: Icons.forum);

  /// Instance
  static const i = MessagesRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.messages;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MessagesPage();
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MessagesRoute.i.getTitle(context.l10n)),
        actions: getSideRoutesAppBarActions(context),
      ),
      backgroundColor: context.colorScheme.surfaceVariant,
      body: const Center(
        child: Text(
          'Messages page is coming soon !\n\nFeel free to make suggestions !\n\nYou can contact the player Mael_Mainsard ;)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
