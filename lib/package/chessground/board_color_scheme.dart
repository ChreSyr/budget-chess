// ignore_for_file: sort_constructors_first

import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/chessground/widgets/background.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:flutter/widgets.dart';

const _boardsPath = 'assets/boards';

/// Describes the color scheme of a [BoardWidget].
///
/// Use the static const members to ensure flutter doesn't rebuild the board
/// more than once.
class BoardColorScheme {
  const BoardColorScheme._({
    required this.name,
    required this.boardSize,
    required this.lightSquare,
    required this.darkSquare,
    required this.whiteCoordBackground,
    required this.blackCoordBackground,
    required this.lastMove,
    required this.selected,
    required this.validMoves,
    required this.validPremoves,
    required this.background,
  });

  factory BoardColorScheme.image({
    required String name,
    required BoardSize boardSize,
    required Color lightSquare,
    required Color darkSquare,
    required HighlightDetails lastMove,
    required HighlightDetails selected,
    required Color validMoves,
    required Color validPremoves,
    required AssetImage image,
  }) =>
      BoardColorScheme._(
        name: name,
        boardSize: boardSize,
        lightSquare: lightSquare,
        darkSquare: darkSquare,
        whiteCoordBackground: ImageBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          image: image,
          boardSize: boardSize,
          coordinates: true,
        ),
        blackCoordBackground: ImageBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          image: image,
          boardSize: boardSize,
          coordinates: true,
          orientation: Side.black,
        ),
        lastMove: lastMove,
        selected: selected,
        validMoves: validMoves,
        validPremoves: validPremoves,
        background: ImageBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          boardSize: boardSize,
          image: image,
        ),
      );

  factory BoardColorScheme.solid({
    required String name,
    required BoardSize boardSize,
    required Color lightSquare,
    required Color darkSquare,
    required HighlightDetails lastMove,
    required HighlightDetails selected,
    required Color validMoves,
    required Color validPremoves,
  }) =>
      BoardColorScheme._(
        name: name,
        boardSize: boardSize,
        lightSquare: lightSquare,
        darkSquare: darkSquare,
        whiteCoordBackground: SolidColorBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          boardSize: boardSize,
          coordinates: true,
        ),
        blackCoordBackground: SolidColorBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          boardSize: boardSize,
          coordinates: true,
          orientation: Side.black,
        ),
        lastMove: lastMove,
        selected: selected,
        validMoves: validMoves,
        validPremoves: validPremoves,
        background: SolidColorBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          boardSize: boardSize,
        ),
      );

  /// The name of this board colors / image
  final String name;

  /// Size of the board
  final BoardSize boardSize;

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
  final Background background;

  factory BoardColorScheme.brown(BoardSize size) => BoardColorScheme.solid(
        name: 'Brown 1',
        boardSize: size,
        lightSquare: const Color(0xfff0d9b6),
        darkSquare: const Color(0xffb58863),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.brown2(BoardSize size) => BoardColorScheme.solid(
        name: 'Brown 2',
        boardSize: size,
        lightSquare: const Color(0xffccb28b),
        darkSquare: const Color(0xff8b5e3f),
        lastMove: const HighlightDetails(solidColor: Color(0x7fffff00)),
        selected: const HighlightDetails(solidColor: Color(0x7fffff00)),
        validMoves: const Color(0x30000000),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.blue(BoardSize size) => BoardColorScheme.solid(
        name: 'Blue 1',
        boardSize: size,
        lightSquare: const Color(0xffdee3e6),
        darkSquare: const Color(0xff8ca2ad),
        lastMove: const HighlightDetails(solidColor: Color(0x809bc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.green(BoardSize size) => BoardColorScheme.solid(
        name: 'Green',
        boardSize: size,
        lightSquare: const Color(0xffffffdd),
        darkSquare: const Color(0xff86a666),
        lastMove: const HighlightDetails(
          solidColor: Color.fromRGBO(0, 155, 199, 0.41),
        ),
        selected:
            const HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
        validMoves: const Color.fromRGBO(0, 0, 0, 0.20),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.blue2(BoardSize size) => BoardColorScheme.image(
        name: 'Blue 2',
        boardSize: size,
        lightSquare: const Color(0xff97b2c7),
        darkSquare: const Color(0xff546f82),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/blue2.jpg'),
      );

  factory BoardColorScheme.blue3(BoardSize size) => BoardColorScheme.image(
        name: 'Blue 3',
        boardSize: size,
        lightSquare: const Color(0xffd9e0e6),
        darkSquare: const Color(0xff315991),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/blue3.jpg'),
      );

  factory BoardColorScheme.blueMarble(BoardSize size) => BoardColorScheme.image(
        name: 'Blue Marble',
        boardSize: size,
        lightSquare: const Color(0xffeae6dd),
        darkSquare: const Color(0xff7c7f87),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/blue-marble.jpg'),
      );

  factory BoardColorScheme.canvas(BoardSize size) => BoardColorScheme.image(
        name: 'Canvas',
        boardSize: size,
        lightSquare: const Color(0xffd7daeb),
        darkSquare: const Color(0xff547388),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/canvas2.jpg'),
      );

  factory BoardColorScheme.greenPlastic(BoardSize size) =>
      BoardColorScheme.image(
        name: 'Green Plastic',
        boardSize: size,
        lightSquare: const Color(0xfff2f9bb),
        darkSquare: const Color(0xff59935d),
        lastMove: const HighlightDetails(
          solidColor: Color.fromRGBO(0, 155, 199, 0.41),
        ),
        selected:
            const HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/green-plastic.png'),
      );

  factory BoardColorScheme.grey(BoardSize size) => BoardColorScheme.image(
        name: 'Grey',
        boardSize: size,
        lightSquare: const Color(0xffb8b8b8),
        darkSquare: const Color(0xff7d7d7d),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/grey.jpg'),
      );

  factory BoardColorScheme.horsey(BoardSize size) => BoardColorScheme.image(
        name: 'Horsey',
        boardSize: size,
        lightSquare: const Color(0xfff0d9b5),
        darkSquare: const Color(0xff946f51),
        lastMove: const HighlightDetails(
          image: AssetImage(
            '$_boardsPath/horsey.last-move.png',
            package: 'chessground',
          ),
        ),
        selected: const HighlightDetails(
          image: AssetImage(
            '$_boardsPath/horsey.selected.png',
            package: 'chessground',
          ),
        ),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/horsey.jpg'),
      );

  factory BoardColorScheme.leather(BoardSize size) => BoardColorScheme.image(
        name: 'Leather',
        boardSize: size,
        lightSquare: const Color(0xffd1d1c9),
        darkSquare: const Color(0xffc28e16),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/leather.jpg'),
      );

  factory BoardColorScheme.maple(BoardSize size) => BoardColorScheme.image(
        name: 'Maple',
        boardSize: size,
        lightSquare: const Color(0xffe8ceab),
        darkSquare: const Color(0xffbc7944),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/maple.jpg'),
      );

  factory BoardColorScheme.maple2(BoardSize size) => BoardColorScheme.image(
        name: 'Maple 2',
        boardSize: size,
        lightSquare: const Color(0xffe2c89f),
        darkSquare: const Color(0xff996633),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/maple2.jpg'),
      );

  factory BoardColorScheme.marble(BoardSize size) => BoardColorScheme.image(
        name: 'Marble',
        boardSize: size,
        lightSquare: const Color(0xff93ab91),
        darkSquare: const Color(0xff4f644e),
        lastMove: const HighlightDetails(
          solidColor: Color.fromRGBO(0, 155, 199, 0.41),
        ),
        selected:
            const HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/marble.jpg'),
      );

  factory BoardColorScheme.metal(BoardSize size) => BoardColorScheme.image(
        name: 'Metal',
        boardSize: size,
        lightSquare: const Color(0xffc9c9c9),
        darkSquare: const Color(0xff727272),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/metal.jpg'),
      );

  factory BoardColorScheme.newspaper(BoardSize size) => BoardColorScheme.image(
        name: 'Newspaper',
        boardSize: size,
        lightSquare: const Color(0xffffffff),
        darkSquare: const Color(0xff8d8d8d),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/newspaper.png'),
      );

  factory BoardColorScheme.olive(BoardSize size) => BoardColorScheme.image(
        name: 'Olive',
        boardSize: size,
        lightSquare: const Color(0xffb8b19f),
        darkSquare: const Color(0xff6d6655),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/olive.jpg'),
      );

  factory BoardColorScheme.pinkPyramid(BoardSize size) =>
      BoardColorScheme.image(
        name: 'Pink Pyramid',
        boardSize: size,
        lightSquare: const Color(0xffe8e9b7),
        darkSquare: const Color(0xffed7272),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/pink-pyramid.png'),
      );

  factory BoardColorScheme.purpleDiag(BoardSize size) => BoardColorScheme.image(
        name: 'Purple Diag',
        boardSize: size,
        lightSquare: const Color(0xffe5daf0),
        darkSquare: const Color(0xff957ab0),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/purple-diag.png'),
      );

  factory BoardColorScheme.wood(BoardSize size) => BoardColorScheme.image(
        name: 'Wood 1',
        boardSize: size,
        lightSquare: const Color(0xffd8a45b),
        darkSquare: const Color(0xff9b4d0f),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/wood.jpg'),
      );

  factory BoardColorScheme.wood2(BoardSize size) => BoardColorScheme.image(
        name: 'Wood 2',
        boardSize: size,
        lightSquare: const Color(0xffa38b5d),
        darkSquare: const Color(0xff6c5017),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/wood2.jpg'),
      );

  factory BoardColorScheme.wood3(BoardSize size) => BoardColorScheme.image(
        name: 'Wood 3',
        boardSize: size,
        lightSquare: const Color(0xffd0ceca),
        darkSquare: const Color(0xff755839),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/wood3.jpg'),
      );

  factory BoardColorScheme.wood4(BoardSize size) => BoardColorScheme.image(
        name: 'Wood 4',
        boardSize: size,
        lightSquare: const Color(0xffcaaf7d),
        darkSquare: const Color(0xff7b5330),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/wood4.jpg'),
      );
}
