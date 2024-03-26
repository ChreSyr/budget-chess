import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/history/history_table.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HistoryRoute extends CCRoute {
  const HistoryRoute._() : super(name: 'history', icon: Icons.history);

  /// Instance
  static const i = HistoryRoute._();

  @override
  String getTitle(AppLocalizations l10n) => 'History'; // TODO : l10n

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HistoryPage();
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HistoryRoute.i.getTitle(context.l10n)),
        actions: getSideRoutesAppBarActions(context),
      ),
      body: SingleChildScrollView(
        child: HistoryTable(user: context.watch<UserCubit>().state),
      ),
    );
  }
}
