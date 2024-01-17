import 'package:crea_chess/route/play/chessground/play_page.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChessgroundBody extends RouteBody {
  const ChessgroundBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.play;
  }

  @override
  Widget build(BuildContext context) {
    return const PlayPage();
  }
}
