import 'package:crea_chess/package/chessground/models.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

const _pieceSetsPath = 'assets/piece_sets';

/// The chess piece set that will be displayed on the board.
enum PieceSet {
  cburnett('Colin M.L. Burnett', PieceSet.cburnettAssets),
  merida('Merida', PieceSet.meridaAssets),
  pirouetti('Pirouetti', PieceSet.pirouettiAssets),
  chessnut('Chessnut', PieceSet.chessnutAssets),
  chess7('Chess7', PieceSet.chess7Assets),
  alpha('Alpha', PieceSet.alphaAssets),
  reillycraig('Reillycraig', PieceSet.reillycraigAssets),
  companion('Companion', PieceSet.companionAssets),
  riohacha('Riohacha', PieceSet.riohachaAssets),
  kosal('Kosal', PieceSet.kosalAssets),
  leipzig('Leipzig', PieceSet.leipzigAssets),
  fantasy('Fantasy', PieceSet.fantasyAssets),
  spatial('Spatial', PieceSet.spatialAssets),
  celtic('Celtic', PieceSet.celticAssets),
  california('California', PieceSet.californiaAssets),
  caliente('Caliente', PieceSet.calienteAssets),
  pixel('Pixel', PieceSet.pixelAssets),
  maestro('Maestro', PieceSet.maestroAssets),
  fresca('Fresca', PieceSet.frescaAssets),
  cardinal('Cardinal', PieceSet.cardinalAssets),
  gioco('Gioco', PieceSet.giocoAssets),
  tatiana('Tatiana', PieceSet.tatianaAssets),
  staunty('Staunty', PieceSet.stauntyAssets),
  governor('Governor', PieceSet.governorAssets),
  dubrovny('Dubrovny', PieceSet.dubrovnyAssets),
  icpieces('Icpieces', PieceSet.icpiecesAssets),
  libra('Libra', PieceSet.libraAssets),
  mpchess('Mpchess', PieceSet.mpchessAssets),
  shapes('Shapes', PieceSet.shapesAssets),
  kiwenSuwi('Kiwen-suwi', PieceSet.kiwenSuwiAssets),
  horsey('Horsey', PieceSet.horseyAssets),
  anarcandy('Anarcandy', PieceSet.anarcandyAssets),
  letter('Letter', PieceSet.letterAssets),
  disguised('Disguised', PieceSet.disguisedAssets);

  const PieceSet(this.label, this.assets);

  final String label;

  /// The [PieceAssets] for this [PieceSet].
  final PieceAssets assets;

  static const PieceAssets alphaAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/alpha/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/alpha/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/alpha/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/alpha/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/alpha/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/alpha/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/alpha/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/alpha/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/alpha/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/alpha/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/alpha/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/alpha/wK.png'),
  });

  static const PieceAssets calienteAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/caliente/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/caliente/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/caliente/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/caliente/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/caliente/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/caliente/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/caliente/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/caliente/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/caliente/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/caliente/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/caliente/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/caliente/wK.png'),
  });

  static const PieceAssets anarcandyAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/anarcandy/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/anarcandy/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/anarcandy/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/anarcandy/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/anarcandy/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/anarcandy/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/anarcandy/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/anarcandy/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/anarcandy/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/anarcandy/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/anarcandy/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/anarcandy/wK.png'),
  });

  static const PieceAssets californiaAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/california/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/california/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/california/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/california/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/california/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/california/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/california/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/california/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/california/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/california/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/california/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/california/wK.png'),
  });

  static const PieceAssets cardinalAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/cardinal/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/cardinal/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/cardinal/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/cardinal/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/cardinal/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/cardinal/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/cardinal/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/cardinal/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/cardinal/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/cardinal/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/cardinal/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/cardinal/wK.png'),
  });

  static const PieceAssets cburnettAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/cburnett/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/cburnett/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/cburnett/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/cburnett/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/cburnett/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/cburnett/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/cburnett/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/cburnett/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/cburnett/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/cburnett/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/cburnett/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/cburnett/wK.png'),
  });

  static const PieceAssets celticAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/celtic/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/celtic/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/celtic/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/celtic/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/celtic/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/celtic/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/celtic/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/celtic/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/celtic/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/celtic/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/celtic/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/celtic/wK.png'),
  });

  static const PieceAssets chess7Assets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/chess7/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/chess7/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/chess7/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/chess7/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/chess7/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/chess7/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/chess7/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/chess7/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/chess7/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/chess7/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/chess7/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/chess7/wK.png'),
  });

  static const PieceAssets chessnutAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/chessnut/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/chessnut/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/chessnut/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/chessnut/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/chessnut/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/chessnut/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/chessnut/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/chessnut/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/chessnut/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/chessnut/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/chessnut/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/chessnut/wK.png'),
  });

  static const PieceAssets companionAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/companion/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/companion/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/companion/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/companion/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/companion/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/companion/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/companion/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/companion/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/companion/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/companion/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/companion/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/companion/wK.png'),
  });

  static const PieceAssets disguisedAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/disguised/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/disguised/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/disguised/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/disguised/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/disguised/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/disguised/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/disguised/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/disguised/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/disguised/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/disguised/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/disguised/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/disguised/wK.png'),
  });

  static const PieceAssets dubrovnyAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/dubrovny/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/dubrovny/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/dubrovny/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/dubrovny/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/dubrovny/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/dubrovny/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/dubrovny/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/dubrovny/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/dubrovny/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/dubrovny/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/dubrovny/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/dubrovny/wK.png'),
  });

  static const PieceAssets fantasyAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/fantasy/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/fantasy/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/fantasy/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/fantasy/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/fantasy/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/fantasy/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/fantasy/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/fantasy/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/fantasy/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/fantasy/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/fantasy/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/fantasy/wK.png'),
  });

  static const PieceAssets frescaAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/fresca/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/fresca/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/fresca/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/fresca/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/fresca/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/fresca/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/fresca/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/fresca/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/fresca/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/fresca/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/fresca/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/fresca/wK.png'),
  });

  static const PieceAssets giocoAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/gioco/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/gioco/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/gioco/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/gioco/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/gioco/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/gioco/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/gioco/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/gioco/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/gioco/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/gioco/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/gioco/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/gioco/wK.png'),
  });

  static const PieceAssets governorAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/governor/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/governor/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/governor/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/governor/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/governor/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/governor/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/governor/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/governor/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/governor/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/governor/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/governor/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/governor/wK.png'),
  });

  static const PieceAssets horseyAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/horsey/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/horsey/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/horsey/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/horsey/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/horsey/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/horsey/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/horsey/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/horsey/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/horsey/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/horsey/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/horsey/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/horsey/wK.png'),
  });

  static const PieceAssets icpiecesAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/icpieces/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/icpieces/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/icpieces/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/icpieces/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/icpieces/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/icpieces/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/icpieces/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/icpieces/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/icpieces/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/icpieces/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/icpieces/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/icpieces/wK.png'),
  });

  static const PieceAssets kiwenSuwiAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/kiwen-suwi/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/kiwen-suwi/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/kiwen-suwi/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/kiwen-suwi/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/kiwen-suwi/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/kiwen-suwi/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/kiwen-suwi/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/kiwen-suwi/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/kiwen-suwi/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/kiwen-suwi/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/kiwen-suwi/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/kiwen-suwi/wK.png'),
  });

  static const PieceAssets kosalAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/kosal/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/kosal/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/kosal/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/kosal/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/kosal/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/kosal/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/kosal/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/kosal/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/kosal/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/kosal/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/kosal/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/kosal/wK.png'),
  });

  static const PieceAssets leipzigAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/leipzig/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/leipzig/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/leipzig/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/leipzig/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/leipzig/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/leipzig/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/leipzig/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/leipzig/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/leipzig/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/leipzig/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/leipzig/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/leipzig/wK.png'),
  });

  static const PieceAssets letterAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/letter/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/letter/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/letter/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/letter/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/letter/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/letter/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/letter/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/letter/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/letter/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/letter/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/letter/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/letter/wK.png'),
  });

  static const PieceAssets libraAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/libra/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/libra/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/libra/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/libra/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/libra/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/libra/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/libra/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/libra/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/libra/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/libra/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/libra/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/libra/wK.png'),
  });

  static const PieceAssets maestroAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/maestro/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/maestro/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/maestro/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/maestro/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/maestro/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/maestro/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/maestro/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/maestro/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/maestro/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/maestro/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/maestro/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/maestro/wK.png'),
  });

  static const PieceAssets meridaAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/merida/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/merida/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/merida/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/merida/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/merida/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/merida/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/merida/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/merida/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/merida/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/merida/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/merida/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/merida/wK.png'),
  });

  static const PieceAssets pirouettiAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/pirouetti/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/pirouetti/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/pirouetti/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/pirouetti/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/pirouetti/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/pirouetti/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/pirouetti/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/pirouetti/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/pirouetti/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/pirouetti/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/pirouetti/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/pirouetti/wK.png'),
  });

  static const PieceAssets mpchessAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/mpchess/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/mpchess/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/mpchess/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/mpchess/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/mpchess/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/mpchess/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/mpchess/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/mpchess/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/mpchess/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/mpchess/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/mpchess/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/mpchess/wK.png'),
  });

  static const PieceAssets pixelAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/pixel/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/pixel/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/pixel/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/pixel/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/pixel/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/pixel/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/pixel/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/pixel/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/pixel/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/pixel/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/pixel/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/pixel/wK.png'),
  });

  static const PieceAssets reillycraigAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/reillycraig/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/reillycraig/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/reillycraig/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/reillycraig/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/reillycraig/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/reillycraig/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/reillycraig/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/reillycraig/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/reillycraig/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/reillycraig/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/reillycraig/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/reillycraig/wK.png'),
  });

  static const PieceAssets riohachaAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/riohacha/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/riohacha/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/riohacha/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/riohacha/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/riohacha/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/riohacha/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/riohacha/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/riohacha/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/riohacha/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/riohacha/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/riohacha/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/riohacha/wK.png'),
  });

  static const PieceAssets shapesAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/shapes/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/shapes/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/shapes/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/shapes/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/shapes/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/shapes/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/shapes/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/shapes/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/shapes/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/shapes/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/shapes/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/shapes/wK.png'),
  });

  static const PieceAssets spatialAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/spatial/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/spatial/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/spatial/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/spatial/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/spatial/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/spatial/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/spatial/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/spatial/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/spatial/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/spatial/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/spatial/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/spatial/wK.png'),
  });

  static const PieceAssets stauntyAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/staunty/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/staunty/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/staunty/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/staunty/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/staunty/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/staunty/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/staunty/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/staunty/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/staunty/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/staunty/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/staunty/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/staunty/wK.png'),
  });

  static const PieceAssets tatianaAssets = IMapConst({
    PieceKind.blackRook:
        AssetImage('$_pieceSetsPath/tatiana/bR.png'),
    PieceKind.blackPawn:
        AssetImage('$_pieceSetsPath/tatiana/bP.png'),
    PieceKind.blackKnight:
        AssetImage('$_pieceSetsPath/tatiana/bN.png'),
    PieceKind.blackBishop:
        AssetImage('$_pieceSetsPath/tatiana/bB.png'),
    PieceKind.blackQueen:
        AssetImage('$_pieceSetsPath/tatiana/bQ.png'),
    PieceKind.blackKing:
        AssetImage('$_pieceSetsPath/tatiana/bK.png'),
    PieceKind.whiteRook:
        AssetImage('$_pieceSetsPath/tatiana/wR.png'),
    PieceKind.whitePawn:
        AssetImage('$_pieceSetsPath/tatiana/wP.png'),
    PieceKind.whiteKnight:
        AssetImage('$_pieceSetsPath/tatiana/wN.png'),
    PieceKind.whiteBishop:
        AssetImage('$_pieceSetsPath/tatiana/wB.png'),
    PieceKind.whiteQueen:
        AssetImage('$_pieceSetsPath/tatiana/wQ.png'),
    PieceKind.whiteKing:
        AssetImage('$_pieceSetsPath/tatiana/wK.png'),
  });
}
