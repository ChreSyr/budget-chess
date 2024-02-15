import 'package:chessground/chessground.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A chessboard widget.
///
/// This widget can be used to display a static board, a dynamic board that
/// shows a live game, or a full user interactable board.
class SetupBoard extends StatefulWidget {
  const SetupBoard({
    required this.size,
    required String halfFen,
    required this.color,
    super.key,
    this.settings = const BoardSettings(),
    this.onDrop,
    this.onMove,
    this.onRemove,
  }) : fen = '8/8/8/8/$halfFen';

  /// Visal size of the board
  final double size;

  /// Settings that control the theme, behavior and purpose of the board.
  final BoardSettings settings;

  /// Data that represents the current state of the board
  final String fen;

  /// The color of the pieces
  final Side color;

  /// Callback called after a piece has been dropped from outside of this board.
  final void Function(DropMove)? onDrop;

  /// Callback called after a move has been made.
  final void Function(Move)? onMove;

  /// Callback called after a piece has been dragged out of the board.
  final void Function(SquareId)? onRemove;

  double get squareSize => size / 8;

  Coord? localOffset2Coord(Offset offset) {
    final x = (offset.dx / squareSize).floor();
    final y = (offset.dy / squareSize).floor();
    final orientX = x;
    final orientY = 7 - y;
    if (orientX >= 0 && orientX <= 7 && orientY >= 0 && orientY <= 7) {
      return Coord(x: orientX, y: orientY);
    } else {
      return null;
    }
  }

  SquareId? localOffset2SquareId(Offset offset) {
    final coord = localOffset2Coord(offset);
    return coord?.squareId;
  }

  @override
  // ignore: library_private_types_in_public_api
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<SetupBoard> {
  Pieces pieces = {};
  _DragAvatar? _dragAvatar;
  SquareId? _dragOrigin;
  List<SquareId> validDests = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.settings.colorScheme;
    const orientation = Side.white;

    final Widget board = Stack(
      children: [
        colorScheme.background,
        if (_dragOrigin != null && _dragAvatar != null)
          PositionedSquare(
            key: ValueKey('${_dragOrigin!}-dragOrigin'),
            size: widget.squareSize,
            orientation: orientation,
            squareId: _dragOrigin!,
            child: Highlight(
              size: widget.squareSize,
              details: colorScheme.selected,
            ),
          ),
        for (final entry in pieces.entries)
          if (entry.key != _dragOrigin)
            PositionedSquare(
              key: ValueKey('${entry.key}-${entry.value.kind.name}'),
              size: widget.squareSize,
              orientation: orientation,
              squareId: entry.key,
              child: PieceWidget(
                piece: entry.value,
                size: widget.squareSize,
                pieceAssets: widget.settings.pieceAssets,
                blindfoldMode: widget.settings.blindfoldMode,
              ),
            ),
        for (final squareId in validDests)
          PositionedSquare(
            size: widget.squareSize,
            orientation: orientation,
            squareId: squareId,
            child: DragTarget<Role>(
              onAccept: (role) => _onDrop(squareId, role),
              builder: (context, candidateData, rejectedData) =>
                  const SizedBox.shrink(),
            ),
          ),
      ],
    );

    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails? details) {},
            onPanDown: _onPanDownPiece,
            onPanUpdate: _onPanUpdatePiece,
            onPanEnd: _onPanEndPiece,
            onPanCancel: _onPanCancelPiece,
            dragStartBehavior: DragStartBehavior.down,
            child: board,
          ),
          // sail above enemy's territory
          Container(
            color: const Color.fromARGB(128, 0, 0, 0),
            height: widget.size / 2,
            width: widget.size,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pieces = readFen(widget.fen);
    print(pieces);
    print(widget.fen);

    for (var rank = 0; rank < 4; rank++) {
      for (var file = 0; file < 8; file++) {
        validDests.add(Coord(x: file, y: rank).squareId);
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
      pieces = readFen(widget.fen);
      print(pieces);
      print(widget.fen);
    }
  }

  // returns the position of the square target during drag as a global offset
  Offset? _squareTargetGlobalOffset(Offset localPosition) {
    final coord = widget.localOffset2Coord(localPosition);
    if (coord == null) return null;
    final localOffset = coord.offset(Side.white, widget.squareSize);
    final box = context.findRenderObject()! as RenderBox;
    final tmpOffset = box.localToGlobal(localOffset);
    return Offset(
      tmpOffset.dx - widget.squareSize / 2,
      tmpOffset.dy - widget.squareSize / 2,
    );
  }

  /// Called when a piece is dropped from the inventory
  void _onDrop(SquareId squareId, Role role) {
    final move = DropMove(
      piece: Piece(
        color: widget.color,
        role: role,
      ),
      squareId: squareId,
    );
    widget.onDrop?.call(move);
  }

  void _onPanDownPiece(DragDownDetails? details) {
    if (details == null) return;

    final squareId = widget.localOffset2SquareId(details.localPosition);
    final piece = squareId != null ? pieces[squareId] : null;
    final feedbackSize = widget.squareSize * widget.settings.dragFeedbackSize;
    if (squareId != null && piece != null && (_isMovable(squareId))) {
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
          width: widget.squareSize * 2,
          height: widget.squareSize * 2,
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
            blindfoldMode: widget.settings.blindfoldMode,
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
    final dest = widget.localOffset2SquareId(localPos);
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
      final squareId = widget.localOffset2SquareId(localPos);
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
    return orig != dest && validDests.contains(dest);
  }

  void _tryMoveTo(SquareId squareId) {
    final draggedPiece = _dragOrigin != null ? pieces[_dragOrigin] : null;
    if (draggedPiece != null && _canMove(_dragOrigin!, squareId)) {
      final move = Move(from: _dragOrigin!, to: squareId);
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

/// Board aware Positioned widget
///
/// Use to position things, such as [Piece], [Highlight] on the board.
/// Since it's a wrapper over a [Positioned] widget it must be a descendant of a
/// [Stack].
class PositionedSquare extends StatelessWidget {
  const PositionedSquare({
    required this.child,
    required this.size,
    required this.orientation,
    required this.squareId,
    super.key,
  });

  final Widget child;
  final double size;
  final Side orientation;
  final SquareId squareId;

  @override
  Widget build(BuildContext context) {
    final offset = Coord.fromSquareId(squareId).offset(orientation, size);
    return Positioned(
      width: size,
      height: size,
      left: offset.dx,
      top: offset.dy,
      child: child,
    );
  }
}

class DropMove {
  const DropMove({required this.piece, required this.squareId});

  final Piece piece;
  final SquareId squareId;
}
