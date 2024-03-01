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
    required this.boardSize,
    required this.lightSquare,
    required this.darkSquare,
    required this.whiteCoordBackground,
    required this.blackCoordBackground,
    required this.lastMove,
    required this.selected,
    required this.validMoves,
    required this.validPremoves,
    this.image,
  });

  factory BoardColorScheme.image({
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
        image: image,
      );

  factory BoardColorScheme.solid({
    required BoardSize boardSize,
    required Color lightSquare,
    required Color darkSquare,
    required HighlightDetails lastMove,
    required HighlightDetails selected,
    required Color validMoves,
    required Color validPremoves,
  }) =>
      BoardColorScheme._(
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
      );

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

  /// An optionnal image for the background
  final AssetImage? image;

  /// BoardWidget background that defines light and dark square colors
  Background background(double boardWidth) => image == null
      ? SolidColorBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          boardSize: boardSize,
        )
      : ImageBackground(
          lightSquare: lightSquare,
          darkSquare: darkSquare,
          boardWidth: boardWidth,
          boardSize: boardSize,
          image: image!,
        );

  factory BoardColorScheme.brown(BoardSize size) => BoardColorScheme.solid(
        boardSize: size,
        lightSquare: const Color(0xfff0d9b6),
        darkSquare: const Color(0xffb58863),
        lastMove: const HighlightDetails(solidColor: Color(0x809cc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.blue(BoardSize size) => BoardColorScheme.solid(
        boardSize: size,
        lightSquare: const Color(0xffdee3e6),
        darkSquare: const Color(0xff8ca2ad),
        lastMove: const HighlightDetails(solidColor: Color(0x809bc700)),
        selected: const HighlightDetails(solidColor: Color(0x6014551e)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.green(BoardSize size) => BoardColorScheme.solid(
        boardSize: size,
        lightSquare: const Color(0xffffffdd),
        darkSquare: const Color(0xff86a666),
        lastMove: const HighlightDetails(
            solidColor: Color.fromRGBO(0, 155, 199, 0.41)),
        selected:
            const HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
        validMoves: const Color.fromRGBO(0, 0, 0, 0.20),
        validPremoves: const Color(0x40203085),
      );

  factory BoardColorScheme.blue2(BoardSize size) => BoardColorScheme.image(
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
        boardSize: size,
        lightSquare: const Color(0xfff2f9bb),
        darkSquare: const Color(0xff59935d),
        lastMove: const HighlightDetails(
            solidColor: Color.fromRGBO(0, 155, 199, 0.41)),
        selected:
            const HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/green-plastic.png'),
      );

  factory BoardColorScheme.grey(BoardSize size) => BoardColorScheme.image(
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
        boardSize: size,
        lightSquare: const Color(0xff93ab91),
        darkSquare: const Color(0xff4f644e),
        lastMove: const HighlightDetails(
            solidColor: Color.fromRGBO(0, 155, 199, 0.41)),
        selected:
            const HighlightDetails(solidColor: Color.fromRGBO(216, 85, 0, 0.3)),
        validMoves: const Color(0x4014551e),
        validPremoves: const Color(0x40203085),
        image: const AssetImage('$_boardsPath/marble.jpg'),
      );

  factory BoardColorScheme.metal(BoardSize size) => BoardColorScheme.image(
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
