import 'package:crea_chess/router/app/hub/chessground/play_page.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

// TODO : delete
class ChessgroundTestingRoute extends CCRoute {
  ChessgroundTestingRoute._() : super(name: 'chessground_testing');

  /// Instance
  static final i = ChessgroundTestingRoute._();

  @override
  String getTitle(AppLocalizations l10n) => l10n.play;

  @override
  Widget build(BuildContext context, GoRouterState state) => const PlayPage();
}
