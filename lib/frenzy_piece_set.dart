import 'package:chessground/chessground.dart' as cg;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

// TODO: set in iratusground later, by default (frenzyground ?)

const cg.PieceAssets frenzyPieceSet = IMapConst({
  cg.PieceKind.blackRook: AssetImage('assets/piece_sets/frenzy/bR.png'),
  cg.PieceKind.blackPawn: AssetImage('assets/piece_sets/frenzy/bP.png'),
  cg.PieceKind.blackKnight: AssetImage('assets/piece_sets/frenzy/bN.png'),
  cg.PieceKind.blackBishop: AssetImage('assets/piece_sets/frenzy/bB.png'),
  cg.PieceKind.blackQueen: AssetImage('assets/piece_sets/frenzy/bQ.png'),
  cg.PieceKind.blackKing: AssetImage('assets/piece_sets/frenzy/bK.png'),
  cg.PieceKind.whiteRook: AssetImage('assets/piece_sets/frenzy/wR.png'),
  cg.PieceKind.whiteKnight: AssetImage('assets/piece_sets/frenzy/wN.png'),
  cg.PieceKind.whiteBishop: AssetImage('assets/piece_sets/frenzy/wB.png'),
  cg.PieceKind.whiteQueen: AssetImage('assets/piece_sets/frenzy/wQ.png'),
  cg.PieceKind.whiteKing: AssetImage('assets/piece_sets/frenzy/wK.png'),
  cg.PieceKind.whitePawn: AssetImage('assets/piece_sets/frenzy/wP.png'),
});
