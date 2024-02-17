import 'package:crea_chess/package/dartchess/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/lichess/lichess_icons.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

extension RuleExt on Rule {
  Widget get icon {
    switch (this) {
      case Rule.chess:
        return Transform.flip(
          flipY: true,
          child: const Icon(LichessIcons.antichess),
        );
      case Rule.antichess:
        return const Icon(LichessIcons.antichess);
      case Rule.kingofthehill:
        return const Icon(LichessIcons.flag);
      case Rule.threecheck:
        return const Icon(LichessIcons.three_check);
      case Rule.atomic:
        return const Icon(LichessIcons.atom);
      case Rule.horde:
        return const Icon(LichessIcons.horde);
      case Rule.racingKings:
        return const Icon(LichessIcons.racing_kings);
      case Rule.crazyhouse:
        return const Icon(LichessIcons.h_square);
    }
  }

  // TODO : l10n
  String explain(AppLocalizations l10n) => name.sentenceCase;
}
