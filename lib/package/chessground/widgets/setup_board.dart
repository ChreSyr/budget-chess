import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A chessboard widget.
///
/// This widget can be used to display a static board, a dynamic board that
/// shows a live game, or a full user interactable board.
class SetupBoard extends StatefulWidget {
  SetupBoard({
    required SetupModel setup,
    required this.color,
    super.key,
    this.settings = const BoardSettings(),
    this.onAdd,
    this.onDrop,
    this.onMove,
    this.onRemove,
    this.interactable = true,
  })  : size = setup.boardSize,
        fen = setup.fenAs(Side.white);

  /// Number of ranks & files of the board
  final BoardSize size;

  /// Settings that control the theme, behavior and purpose of the board.
  final BoardSettings settings;

  /// Data that represents the current state of the board
  final String fen;

  /// The color of the pieces
  final Side color;

  /// Callback called after a valid destination has been selected.
  final void Function(String)? onAdd;

  /// Callback called after a piece has been dropped from outside of this board.
  final void Function(CGDropMove)? onDrop;

  /// Callback called after a move has been made.
  final void Function(CGMove)? onMove;

  /// Callback called after a piece has been dragged out of the board.
  final void Function(SquareId)? onRemove;

  final bool interactable;

  Coord? localOffset2Coord(Offset offset, double squareSize) {
    final x = (offset.dx / squareSize).floor();
    final y = (offset.dy / squareSize).floor();
    final orientX = x;
    final orientY = size.ranks - 1 - y;
    if (orientX >= 0 &&
        orientX <= (size.files - 1) &&
        orientY >= 0 &&
        orientY <= (size.ranks - 1)) {
      return Coord(x: orientX, y: orientY, boardSize: size);
    } else {
      return null;
    }
  }

  SquareId? localOffset2SquareId(Offset offset, double squareSize) {
    final coord = localOffset2Coord(offset, squareSize);
    return coord?.squareId;
  }

  @override
  // ignore: library_private_types_in_public_api
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<SetupBoard> {
  double squareSize = 0;
  Pieces pieces = {};
  late BoardColorScheme colorScheme;
  _DragAvatar? _dragAvatar;
  SquareId? _dragOrigin;
  SquareId? _dropTarget;
  List<SquareId> dragTargets = [];

  @override
  Widget build(BuildContext context) {
    const orientation = Side.white;

    return LayoutBuilder(
      builder: (context, constraints) {
        final boardWidth = constraints.maxWidth;
        squareSize = boardWidth / widget.size.files;

        final Widget board = Stack(
          children: [
            colorScheme.background,
            if (_dragOrigin != null && _dragAvatar != null)
              PositionedSquare(
                key: ValueKey('${_dragOrigin!}-dragOrigin'),
                size: squareSize,
                orientation: orientation,
                squareId: _dragOrigin!,
                boardSize: widget.size,
                child: Highlight(
                  size: squareSize,
                  details: colorScheme.selected,
                ),
              ),
            for (final entry in pieces.entries)
              if (entry.key != _dragOrigin)
                PositionedSquare(
                  key: ValueKey('${entry.key}-${entry.value.kind.name}'),
                  size: squareSize,
                  orientation: orientation,
                  squareId: entry.key,
                  boardSize: widget.size,
                  child: PieceWidget(
                    piece: entry.value,
                    size: squareSize,
                    pieceAssets: widget.settings.pieceAssets,
                  ),
                ),
            for (final squareId in dragTargets)
              PositionedSquare(
                size: squareSize,
                orientation: orientation,
                squareId: squareId,
                boardSize: widget.size,
                child: DragTarget<Role>(
                  onAccept: (role) {
                    _onDrop(squareId, role);
                    setState(() {
                      _dropTarget = null;
                    });
                  },
                  builder: (context, candidateData, rejectedData) =>
                      const SizedBox.shrink(),
                  onMove: (_) => _dropTarget == squareId
                      ? null
                      : setState(() {
                          _dropTarget = squareId;
                        }),
                  onLeave: (_) => _dropTarget != squareId
                      ? null
                      : setState(() {
                          _dropTarget = null;
                        }),
                ),
              ),
            if (_dropTarget != null)
              Builder(
                builder: (context) {
                  final coord = Coord.fromSquareId(
                    _dropTarget!,
                    boardSize: widget.size,
                  );
                  final pos = _dropTargetLocalOffsetFromCoord(coord);
                  if (pos == null) return CCGap.zero;

                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: IgnorePointer(
                      child: Container(
                        width: squareSize * 2,
                        height: squareSize * 2,
                        decoration: const BoxDecoration(
                          color: Color(0x33000000),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        );

        return SizedBox(
          width: boardWidth,
          height: squareSize * widget.size.ranks,
          child: Stack(
            children: [
              if (widget.interactable)
                GestureDetector(
                  onPanDown: _onPanDownPiece,
                  onPanUpdate: _onPanUpdatePiece,
                  onPanEnd: _onPanEndPiece,
                  onPanCancel: _onPanCancelPiece,
                  dragStartBehavior: DragStartBehavior.down,
                  child: board,
                )
              else
                board,
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    colorScheme = widget.settings.colorScheme(widget.size);
    pieces = readFen(fen: widget.fen, boardSize: widget.size);
    for (var rank = 0; rank < widget.size.ranks; rank++) {
      for (var file = 0; file < widget.size.files; file++) {
        dragTargets.add(
          Coord(
            x: file,
            y: rank,
            boardSize: widget.size,
          ).squareId,
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dragAvatar?.cancel();
  }

  @override
  void didUpdateWidget(SetupBoard oldBoard) {
    super.didUpdateWidget(oldBoard);
    if (oldBoard.fen != widget.fen) {
      pieces = readFen(fen: widget.fen, boardSize: widget.size);
    }
  }

  // returns the position of the square target during drag as a global offset
  Offset? _squareTargetGlobalOffset(Offset localPosition) {
    final coord = widget.localOffset2Coord(localPosition, squareSize);
    if (coord == null) return null;
    final localOffset = coord.offset(Side.white, squareSize);
    final box = context.findRenderObject()! as RenderBox;
    final tmpOffset = box.localToGlobal(localOffset);
    return Offset(
      tmpOffset.dx - squareSize / 2,
      tmpOffset.dy - squareSize / 2,
    );
  }

  Offset? _dropTargetLocalOffsetFromCoord(Coord? coord) {
    if (coord == null) return null;
    final localOffset = coord.offset(Side.white, squareSize);
    return Offset(
      localOffset.dx - squareSize / 2,
      localOffset.dy - squareSize / 2,
    );
  }

  /// Called when a piece is dropped from the inventory
  void _onDrop(SquareId squareId, Role role) {
    final move = CGDropMove(
      role: role,
      squareId: squareId,
    );
    widget.onDrop?.call(move);
  }

  void _onPanDownPiece(DragDownDetails? details) {
    if (details == null) return;

    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId == null) return; // should never happen

    final piece = pieces[squareId];
    if (piece == null) return widget.onAdd?.call(squareId);

    final feedbackSize = squareSize * widget.settings.dragFeedbackSize;
    if (_isMovable(squareId)) {
      setState(() {
        _dragOrigin = squareId;
      });
      final squareTargetOffset =
          _squareTargetGlobalOffset(details.localPosition);
      _dragAvatar = _DragAvatar(
        overlayState: Overlay.of(context, debugRequiredFor: widget),
        initialPosition: details.globalPosition,
        initialTargetPosition: squareTargetOffset,
        squareTargetFeedback: Container(
          width: squareSize * 2,
          height: squareSize * 2,
          decoration: const BoxDecoration(
            color: Color(0x33000000),
            shape: BoxShape.circle,
          ),
        ),
        pieceFeedback: Transform.translate(
          offset: Offset(
            ((widget.settings.dragFeedbackOffset.dx - 1) * feedbackSize) / 2,
            ((widget.settings.dragFeedbackOffset.dy - 1) * feedbackSize) / 2,
          ),
          child: PieceWidget(
            piece: piece,
            size: feedbackSize,
            pieceAssets: widget.settings.pieceAssets,
          ),
        ),
      );
    }
  }

  void _onPanUpdatePiece(DragUpdateDetails? details) {
    if (details == null || _dragAvatar == null) return;
    final squareTargetOffset = _squareTargetGlobalOffset(details.localPosition);
    _dragAvatar?.update(details);
    final box = context.findRenderObject()! as RenderBox;
    final localPos = box.globalToLocal(_dragAvatar!._position);
    final dest = widget.localOffset2SquareId(localPos, squareSize);
    if (_dragOrigin != null && dest != null && _canMove(_dragOrigin!, dest)) {
      _dragAvatar?.updateSquareTarget(squareTargetOffset);
    } else {
      _dragAvatar?.updateSquareTarget(null);
    }
  }

  void _onPanEndPiece(DragEndDetails? details) {
    if (_dragAvatar != null) {
      final box = context.findRenderObject()! as RenderBox;
      final localPos = box.globalToLocal(_dragAvatar!._position);
      final squareId = widget.localOffset2SquareId(localPos, squareSize);
      if (squareId == _dragOrigin) {
        // back to where it was
      } else if (squareId != null && _canMove(_dragOrigin!, squareId)) {
        _tryMoveTo(squareId);
      } else {
        _removeDraggedPiece();
      }
    }
    _dragAvatar?.end();
    _dragAvatar = null;
    setState(() {
      _dragOrigin = null;
    });
  }

  void _onPanCancelPiece() {
    _dragAvatar?.cancel();
    _dragAvatar = null;
    setState(() {
      _dragOrigin = null;
    });
  }

  void _removeDraggedPiece() {
    if (_dragOrigin != null) widget.onRemove?.call(_dragOrigin!);
  }

  bool _isMovable(SquareId squareId) => pieces[squareId] != null;

  bool _canMove(SquareId orig, SquareId dest) {
    return orig != dest && dragTargets.contains(dest);
  }

  void _tryMoveTo(SquareId squareId) {
    final draggedPiece = _dragOrigin != null ? pieces[_dragOrigin] : null;
    if (draggedPiece != null && _canMove(_dragOrigin!, squareId)) {
      final move = CGMove(from: _dragOrigin!, to: squareId);
      widget.onMove?.call(move);
    }
    setState(() {
      _dragOrigin = null;
    });
  }
}

// For the logic behind this see:
// https://github.com/flutter/flutter/blob/stable/packages/flutter/lib/src/widgets/drag_target.dart#L805
// and:
// https://github.com/flutter/flutter/blob/ee4e09cce01d6f2d7f4baebd247fde02e5008851/packages/flutter/lib/src/widgets/overlay.dart#L58
class _DragAvatar {
  _DragAvatar({
    required this.overlayState,
    required Offset initialPosition,
    required this.pieceFeedback,
    required this.squareTargetFeedback,
    Offset? initialTargetPosition,
  })  : _position = initialPosition,
        _squareTargetPosition = initialTargetPosition {
    _pieceEntry = OverlayEntry(builder: _buildPieceFeedback);
    _squareTargetEntry = OverlayEntry(builder: _buildSquareTargetFeedback);
    overlayState
      ..insert(_squareTargetEntry)
      ..insert(_pieceEntry);
    _updateDrag();
  }

  final Widget pieceFeedback;
  final Widget squareTargetFeedback;
  final OverlayState overlayState;
  Offset _position;
  Offset? _squareTargetPosition;
  late final OverlayEntry _pieceEntry;
  late final OverlayEntry _squareTargetEntry;

  void update(DragUpdateDetails details) {
    _position += details.delta;
    _updateDrag();
  }

  void updateSquareTarget(Offset? squareTargetOffset) {
    if (_squareTargetPosition != squareTargetOffset) {
      _squareTargetPosition = squareTargetOffset;
      _squareTargetEntry.markNeedsBuild();
    }
  }

  void end() {
    finishDrag();
  }

  void cancel() {
    finishDrag();
  }

  void _updateDrag() {
    _pieceEntry.markNeedsBuild();
  }

  void finishDrag() {
    _pieceEntry.remove();
    _squareTargetEntry.remove();
  }

  Widget _buildPieceFeedback(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: IgnorePointer(
        child: pieceFeedback,
      ),
    );
  }

  Widget _buildSquareTargetFeedback(BuildContext context) {
    if (_squareTargetPosition != null) {
      return Positioned(
        left: _squareTargetPosition!.dx,
        top: _squareTargetPosition!.dy,
        child: IgnorePointer(
          child: squareTargetFeedback,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

/// BoardWidget aware Positioned widget
///
/// Use to position things, such as [CGPiece], [Highlight] on the board.
/// Since it's a wrapper over a [Positioned] widget it must be a descendant of a
/// [Stack].
class PositionedSquare extends StatelessWidget {
  const PositionedSquare({
    required this.child,
    required this.size,
    required this.orientation,
    required this.squareId,
    required this.boardSize,
    super.key,
  });

  final Widget child;
  final double size;
  final Side orientation;
  final SquareId squareId;
  final BoardSize boardSize;

  @override
  Widget build(BuildContext context) {
    final offset = Coord.fromSquareId(squareId, boardSize: boardSize)
        .offset(orientation, size);
    return Positioned(
      width: size,
      height: size,
      left: offset.dx,
      top: offset.dy,
      child: child,
    );
  }
}

class CGDropMove {
  const CGDropMove({required this.role, required this.squareId});

  final Role role;
  final SquareId squareId;
}
