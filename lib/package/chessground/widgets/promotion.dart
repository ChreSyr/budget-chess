import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/chessground/widgets/piece.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:flutter/widgets.dart';

class PromotionSelector extends StatelessWidget {
  const PromotionSelector({
    required this.move,
    required this.color,
    required this.boardSize,
    required this.squareSize,
    required this.orientation,
    required this.onSelect,
    required this.onCancel,
    required this.pieceAssets,
    super.key,
  });

  final CGMove move;
  final Side color;
  final BoardSize boardSize;
  final double squareSize;
  final Side orientation;
  final void Function(CGMove, CGPiece) onSelect;
  final void Function(CGMove) onCancel;
  final PieceAssets pieceAssets;

  SquareId get squareId => move.to;

  @override
  Widget build(BuildContext context) {
    final file = squareId[0];
    final rank = squareId[1];

    const promotionRoles = [
      Role.queen,
      Role.knight,
      Role.rook,
      Role.bishop,
    ];

    final coord =
        (orientation == Side.white && rank == boardSize.rankIds.last ||
                orientation == Side.black && rank == '1')
            ? Coord.fromSquareId(squareId, boardSize: boardSize)
            : Coord.fromSquareId(
                file +
                    (orientation == Side.white
                        ? promotionRoles.length.toString()
                        : (boardSize.ranks - promotionRoles.length).toString()),
                boardSize: boardSize,
              );
    final offset = coord.offset(orientation, squareSize);

    return GestureDetector(
      onTap: () => onCancel(move),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xB3161512),
        child: Stack(
          children: [
            Positioned(
              width: squareSize,
              height: squareSize * 4,
              left: offset.dx,
              top: offset.dy,
              child: Column(
                children: promotionRoles.map((role) {
                  final piece = CGPiece(
                    color: color,
                    role: role,
                    promoted: true,
                  );
                  return GestureDetector(
                    onTap: () => onSelect(move, piece),
                    child: Stack(
                      children: [
                        Container(
                          width: squareSize,
                          height: squareSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFb0b0b0),
                              ),
                              BoxShadow(
                                color: Color(0xFF808080),
                                blurRadius: 25,
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: PieceWidget(
                            piece: piece,
                            size: squareSize - 10.0,
                            pieceAssets: pieceAssets,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(growable: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
