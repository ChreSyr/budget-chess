import 'package:crea_chess/route/play/setup/setup_body.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameBody extends RouteBody {
  const GameBody({super.key}) : super(padded: false);

  @override
  String getTitle(AppLocalizations l10n) {
    return 'Game'; // TODO : l10n
  }

  @override
  Widget build(BuildContext context) {
    return const SetupBody();
  }
}
