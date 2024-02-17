import 'package:crea_chess/package/chessground/export.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

// LATER: set in iratusground, by default (frenzyground ?)

const PieceAssets frenzyPieceSet = IMapConst({
  PieceKind.blackRook: AssetImage('assets/piece_sets/frenzy/bR.png'),
  PieceKind.blackPawn: AssetImage('assets/piece_sets/frenzy/bP.png'),
  PieceKind.blackKnight: AssetImage('assets/piece_sets/frenzy/bN.png'),
  PieceKind.blackBishop: AssetImage('assets/piece_sets/frenzy/bB.png'),
  PieceKind.blackQueen: AssetImage('assets/piece_sets/frenzy/bQ.png'),
  PieceKind.blackKing: AssetImage('assets/piece_sets/frenzy/bK.png'),
  PieceKind.whiteRook: AssetImage('assets/piece_sets/frenzy/wR.png'),
  PieceKind.whiteKnight: AssetImage('assets/piece_sets/frenzy/wN.png'),
  PieceKind.whiteBishop: AssetImage('assets/piece_sets/frenzy/wB.png'),
  PieceKind.whiteQueen: AssetImage('assets/piece_sets/frenzy/wQ.png'),
  PieceKind.whiteKing: AssetImage('assets/piece_sets/frenzy/wK.png'),
  PieceKind.whitePawn: AssetImage('assets/piece_sets/frenzy/wP.png'),
});
