import 'dart:math';

import 'package:chessground/chessground.dart';
import 'package:dartchess_webok/dartchess_webok.dart' as dc;
import 'package:fast_immutable_collections/fast_immutable_collections.dart'
    hide Tuple2;
import 'package:flutter/material.dart';

class DrawShapesPage extends StatefulWidget {
  const DrawShapesPage({super.key});

  @override
  State<DrawShapesPage> createState() => _DrawShapesPageState();
}

class _DrawShapesPageState extends State<DrawShapesPage> {
  dc.Position<dc.Chess> position = dc.Chess.initial;
  Side orientation = Side.white;
  String fen = dc.kInitialBoardFEN;
  Move? lastMove;
  ValidMoves validMoves = IMap(const {});
  Side sideToMove = Side.white;
  PieceSet pieceSet = PieceSet.merida;
  BoardTheme boardTheme = BoardTheme.blue;
  ISet<Shape> shapes = ISet();
  bool drawShapes = true;
  Color newShapeColor = const Color(0xAA15781b);
  final Color defaultShapeColor = const Color(0xAA15781b);
  dc.Position<dc.Chess>? lastPos;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Shapes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Board(
              size: screenWidth,
              settings: BoardSettings(
                pieceAssets: pieceSet.assets,
                colorScheme: boardTheme.colors,
                drawShape: DrawShapeOptions(
                  enable: drawShapes,
                  onCompleteShape: _onCompleteShape,
                  newShapeColor: newShapeColor,
                ),
              ),
              data: BoardData(
                interactableSide: (position.turn == dc.Side.white
                    ? InteractableSide.white
                    : InteractableSide.black),
                validMoves: validMoves,
                orientation: orientation,
                fen: fen,
                lastMove: lastMove,
                sideToMove:
                    position.turn == dc.Side.white ? Side.white : Side.black,
                isCheck: position.isCheck,
                shapes: shapes.isNotEmpty ? shapes : null,
              ),
              onMove: _onUserMoveFreePlay,
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _toggleDrawing,
                  child: Text('Drawing: ${drawShapes ? 'ON' : 'OFF'}'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  child: const Text('Clear'),
                  onPressed: () {
                    setState(() {
                      shapes = ISet();
                    });
                  },
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message:
                      'Toggles Color between a random color and default green.',
                  child: ElevatedButton(
                    child: Text('$newShapeColor'),
                    onPressed: () {
                      setState(() {
                        newShapeColor = (newShapeColor == defaultShapeColor)
                            ? Color(Random().nextInt(0x00ffffff) + 0xAA000000)
                            : defaultShapeColor;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDrawing() {
    setState(() {
      drawShapes = !drawShapes;
    });
  }

  @override
  void initState() {
    validMoves = dc.algebraicLegalMoves(position);
    super.initState();
  }

  void _onCompleteShape(Shape shape) {
    if (shapes.any((element) => element == shape)) {
      setState(() {
        shapes = shapes.remove(shape);
      });
      return;
    } else {
      setState(() {
        shapes = shapes.add(shape);
      });
    }
  }

  void _onUserMoveFreePlay(Move move, {bool? isDrop, bool? isPremove}) {
    lastPos = position;
    final m = dc.Move.fromUci(move.uci)!;
    setState(() {
      position = position.playUnchecked(m);
      lastMove = move;
      fen = position.fen;
      validMoves = dc.algebraicLegalMoves(position);
    });
  }
}
