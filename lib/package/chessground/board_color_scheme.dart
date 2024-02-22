import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/chessground/widgets/background.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:flutter/widgets.dart';

const _boardsPath = 'assets/boards';

/// Describes the color scheme of a [BoardWidget].
///
/// Use the static const members to ensure flutter doesn't rebuild the board
/// more than once.
class BoardColorScheme {
  const BoardColorScheme({
    required this.lightSquare,
    required this.darkSquare,
    required this.whiteCoordBackground,
    required this.blackCoordBackground,
    required this.lastMove,
    required this.selected,
    required this.validMoves,
    required this.validPremoves,
  });

  /// Light square color of the board
  final Color lightSquare;

  /// Dark square color of the board
  final Color darkSquare;

  /// BoardWidget background that defines light and dark square colors and with
  /// white facing coordinates included
  final Background whiteCoordBackground;

  /// BoardWidget background that defines light and dark square colors and with
  /// black facing coordinates included
  final Background blackCoordBackground;

  /// Color of highlighted last move
  final HighlightDetails lastMove;

  /// Color of highlighted selected square
  final HighlightDetails selected;

  /// Color of squares occupied with valid moves dots
  final Color validMoves;

  /// Color of squares occupied with valid premoves dots
  final Color validPremoves;

  /// BoardWidget background that defines light and dark square colors
  Background background(BoardSize boardSize) => SolidColorBackground(
        lightSquare: lightSquare,
        darkSquare: darkSquare,
        boardSize: boardSize,
      );

  static const brown = BoardColorScheme(
    lightSquare: Color(0xfff0d9b6),
    darkSquare: Color(0xffb58863),
    whiteCoordBackground: SolidColorBackground(
      lightSquare: Color(0xfff0d9b6),
      darkSquare: Color(0xffb58863),
      coordinates: true,
    ),
    blackCoordBackground: SolidColorBackground(
      lightSquare: Color(0xfff0d9b6),
      darkSquare: Color(0xffb58863),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const blue = BoardColorScheme(
    lightSquare: Color(0xffdee3e6),
    darkSquare: Color(0xff8ca2ad),
    whiteCoordBackground: SolidColorBackground(
      lightSquare: Color(0xffdee3e6),
      darkSquare: Color(0xff8ca2ad),
      coordinates: true,
    ),
    blackCoordBackground: SolidColorBackground(
      lightSquare: Color(0xffdee3e6),
      darkSquare: Color(0xff8ca2ad),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809bc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const green = BoardColorScheme(
    lightSquare: Color(0xffffffdd),
    darkSquare: Color(0xff86a666),
    whiteCoordBackground: SolidColorBackground(
      lightSquare: Color(0xffffffdd),
      darkSquare: Color(0xff86a666),
      coordinates: true,
    ),
    blackCoordBackground: SolidColorBackground(
      lightSquare: Color(0xffffffdd),
      darkSquare: Color(0xff86a666),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color.fromRGBO(0, 155, 199, 0.41)),
    selected: HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
    validMoves: Color.fromRGBO(0, 0, 0, 0.20),
    validPremoves: Color(0x40203085),
  );

  static const blue2 = BoardColorScheme(
    lightSquare: Color(0xff97b2c7),
    darkSquare: Color(0xff546f82),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xff97b2c7),
      darkSquare: Color(0xff546f82),
      image: AssetImage('$_boardsPath/blue2.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xff97b2c7),
      darkSquare: Color(0xff546f82),
      image: AssetImage('$_boardsPath/blue2.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const blue3 = BoardColorScheme(
    lightSquare: Color(0xffd9e0e6),
    darkSquare: Color(0xff315991),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffd9e0e6),
      darkSquare: Color(0xff315991),
      image: AssetImage('$_boardsPath/blue3.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffd9e0e6),
      darkSquare: Color(0xff315991),
      image: AssetImage('$_boardsPath/blue3.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const blueMarble = BoardColorScheme(
    lightSquare: Color(0xffeae6dd),
    darkSquare: Color(0xff7c7f87),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffeae6dd),
      darkSquare: Color(0xff7c7f87),
      image: AssetImage('$_boardsPath/blue-marble.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffeae6dd),
      darkSquare: Color(0xff7c7f87),
      image: AssetImage('$_boardsPath/blue-marble.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const canvas = BoardColorScheme(
    lightSquare: Color(0xffd7daeb),
    darkSquare: Color(0xff547388),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffd7daeb),
      darkSquare: Color(0xff547388),
      image: AssetImage('$_boardsPath/canvas2.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffd7daeb),
      darkSquare: Color(0xff547388),
      image: AssetImage('$_boardsPath/canvas2.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const greenPlastic = BoardColorScheme(
    lightSquare: Color(0xfff2f9bb),
    darkSquare: Color(0xff59935d),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xfff2f9bb),
      darkSquare: Color(0xff59935d),
      image: AssetImage('$_boardsPath/green-plastic.png'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xfff2f9bb),
      darkSquare: Color(0xff59935d),
      image: AssetImage('$_boardsPath/green-plastic.png'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color.fromRGBO(0, 155, 199, 0.41)),
    selected: HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const grey = BoardColorScheme(
    lightSquare: Color(0xffb8b8b8),
    darkSquare: Color(0xff7d7d7d),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffb8b8b8),
      darkSquare: Color(0xff7d7d7d),
      image: AssetImage('$_boardsPath/grey.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffb8b8b8),
      darkSquare: Color(0xff7d7d7d),
      image: AssetImage('$_boardsPath/grey.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const horsey = BoardColorScheme(
    lightSquare: Color(0xfff0d9b5),
    darkSquare: Color(0xff946f51),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xfff0d9b5),
      darkSquare: Color(0xff946f51),
      image: AssetImage('$_boardsPath/horsey.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xfff0d9b5),
      darkSquare: Color(0xff946f51),
      image: AssetImage('$_boardsPath/horsey.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(
      image: AssetImage(
        '$_boardsPath/horsey.last-move.png',
        package: 'chessground',
      ),
    ),
    selected: HighlightDetails(
      image: AssetImage(
        '$_boardsPath/horsey.selected.png',
        package: 'chessground',
      ),
    ),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const leather = BoardColorScheme(
    lightSquare: Color(0xffd1d1c9),
    darkSquare: Color(0xffc28e16),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffd1d1c9),
      darkSquare: Color(0xffc28e16),
      image: AssetImage('$_boardsPath/leather.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffd1d1c9),
      darkSquare: Color(0xffc28e16),
      image: AssetImage('$_boardsPath/leather.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const maple = BoardColorScheme(
    lightSquare: Color(0xffe8ceab),
    darkSquare: Color(0xffbc7944),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffe8ceab),
      darkSquare: Color(0xffbc7944),
      image: AssetImage('$_boardsPath/maple.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffe8ceab),
      darkSquare: Color(0xffbc7944),
      image: AssetImage('$_boardsPath/maple.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const maple2 = BoardColorScheme(
    lightSquare: Color(0xffe2c89f),
    darkSquare: Color(0xff996633),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffe2c89f),
      darkSquare: Color(0xff996633),
      image: AssetImage('$_boardsPath/maple2.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffe2c89f),
      darkSquare: Color(0xff996633),
      image: AssetImage('$_boardsPath/maple2.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const marble = BoardColorScheme(
    lightSquare: Color(0xff93ab91),
    darkSquare: Color(0xff4f644e),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xff93ab91),
      darkSquare: Color(0xff4f644e),
      image: AssetImage('$_boardsPath/marble.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xff93ab91),
      darkSquare: Color(0xff4f644e),
      image: AssetImage('$_boardsPath/marble.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color.fromRGBO(0, 155, 199, 0.41)),
    selected: HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const metal = BoardColorScheme(
    lightSquare: Color(0xffc9c9c9),
    darkSquare: Color(0xff727272),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffc9c9c9),
      darkSquare: Color(0xff727272),
      image: AssetImage('$_boardsPath/metal.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffc9c9c9),
      darkSquare: Color(0xff727272),
      image: AssetImage('$_boardsPath/metal.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const newspaper = BoardColorScheme(
    lightSquare: Color(0xffffffff),
    darkSquare: Color(0xff8d8d8d),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffffffff),
      darkSquare: Color(0xff8d8d8d),
      image: AssetImage('$_boardsPath/newspaper.png'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffffffff),
      darkSquare: Color(0xff8d8d8d),
      image: AssetImage('$_boardsPath/newspaper.png'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const olive = BoardColorScheme(
    lightSquare: Color(0xffb8b19f),
    darkSquare: Color(0xff6d6655),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffb8b19f),
      darkSquare: Color(0xff6d6655),
      image: AssetImage('$_boardsPath/olive.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffb8b19f),
      darkSquare: Color(0xff6d6655),
      image: AssetImage('$_boardsPath/olive.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const pinkPyramid = BoardColorScheme(
    lightSquare: Color(0xffe8e9b7),
    darkSquare: Color(0xffed7272),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffe8e9b7),
      darkSquare: Color(0xffed7272),
      image: AssetImage('$_boardsPath/pink-pyramid.png'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffe8e9b7),
      darkSquare: Color(0xffed7272),
      image: AssetImage('$_boardsPath/pink-pyramid.png'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const purpleDiag = BoardColorScheme(
    lightSquare: Color(0xffe5daf0),
    darkSquare: Color(0xff957ab0),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffe5daf0),
      darkSquare: Color(0xff957ab0),
      image: AssetImage('$_boardsPath/purple-diag.png'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffe5daf0),
      darkSquare: Color(0xff957ab0),
      image: AssetImage('$_boardsPath/purple-diag.png'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const wood = BoardColorScheme(
    lightSquare: Color(0xffd8a45b),
    darkSquare: Color(0xff9b4d0f),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffd8a45b),
      darkSquare: Color(0xff9b4d0f),
      image: AssetImage('$_boardsPath/wood.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffd8a45b),
      darkSquare: Color(0xff9b4d0f),
      image: AssetImage('$_boardsPath/wood.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const wood2 = BoardColorScheme(
    lightSquare: Color(0xffa38b5d),
    darkSquare: Color(0xff6c5017),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffa38b5d),
      darkSquare: Color(0xff6c5017),
      image: AssetImage('$_boardsPath/wood2.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffa38b5d),
      darkSquare: Color(0xff6c5017),
      image: AssetImage('$_boardsPath/wood2.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const wood3 = BoardColorScheme(
    lightSquare: Color(0xffd0ceca),
    darkSquare: Color(0xff755839),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffd0ceca),
      darkSquare: Color(0xff755839),
      image: AssetImage('$_boardsPath/wood3.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffd0ceca),
      darkSquare: Color(0xff755839),
      image: AssetImage('$_boardsPath/wood3.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );

  static const wood4 = BoardColorScheme(
    lightSquare: Color(0xffcaaf7d),
    darkSquare: Color(0xff7b5330),
    whiteCoordBackground: ImageBackground(
      lightSquare: Color(0xffcaaf7d),
      darkSquare: Color(0xff7b5330),
      image: AssetImage('$_boardsPath/wood4.jpg'),
      coordinates: true,
    ),
    blackCoordBackground: ImageBackground(
      lightSquare: Color(0xffcaaf7d),
      darkSquare: Color(0xff7b5330),
      image: AssetImage('$_boardsPath/wood4.jpg'),
      coordinates: true,
      orientation: Side.black,
    ),
    lastMove: HighlightDetails(solidColor: Color(0x809cc700)),
    selected: HighlightDetails(solidColor: Color(0x6014551e)),
    validMoves: Color(0x4014551e),
    validPremoves: Color(0x40203085),
  );
}
