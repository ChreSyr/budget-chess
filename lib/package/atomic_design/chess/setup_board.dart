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
    required this.data,
    super.key,
    this.settings = const BoardSettings(),
    this.onMove,
  });

  /// Visal size of the board
  final double size;

  /// Settings that control the theme, behavior and purpose of the board.
  final BoardSettings settings;

  /// Data that represents the current state of the board
  final BoardData data;

  /// Callback called after a move has been made.
  final void Function(Move)? onMove;

  double get squareSize => size / 8;

  Coord? localOffset2Coord(Offset offset) {
    final x = (offset.dx / squareSize).floor();
    final y = (offset.dy / squareSize).floor();
    final orientX = data.orientation == Side.black ? 7 - x : x;
    final orientY = data.orientation == Side.black ? y : 7 - y;
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
  Map<String, (PositionedPiece, PositionedPiece)> translatingPieces = {};
  Map<String, Piece> fadingPieces = {};
  SquareId? selected;
  Move? _lastDrop;
  _DragAvatar? _dragAvatar;
  SquareId? _dragOrigin;
  List<SquareId> validDests = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.settings.colorScheme;
    final Widget board = Stack(
      children: [
        if (widget.settings.enableCoordinates)
          widget.data.orientation == Side.white
              ? colorScheme.whiteCoordBackground
              : colorScheme.blackCoordBackground
        else
          colorScheme.background,
        if (selected != null && _dragAvatar != null)
          PositionedSquare(
            key: ValueKey('${selected!}-selected'),
            size: widget.squareSize,
            orientation: widget.data.orientation,
            squareId: selected!,
            child: Highlight(
              size: widget.squareSize,
              details: colorScheme.selected,
            ),
          ),
        for (final entry in fadingPieces.entries)
          PositionedSquare(
            key: ValueKey('${entry.key}-${entry.value.kind.name}-fading'),
            size: widget.squareSize,
            orientation: widget.data.orientation,
            squareId: entry.key,
            child: PieceFadeOut(
              duration: widget.settings.animationDuration,
              piece: entry.value,
              size: widget.squareSize,
              pieceAssets: widget.settings.pieceAssets,
              blindfoldMode: widget.settings.blindfoldMode,
              onComplete: () {
                fadingPieces.remove(entry.key);
              },
            ),
          ),
        for (final entry in pieces.entries)
          if (!translatingPieces.containsKey(entry.key) &&
              entry.key != _dragOrigin)
            PositionedSquare(
              key: ValueKey('${entry.key}-${entry.value.kind.name}'),
              size: widget.squareSize,
              orientation: widget.data.orientation,
              squareId: entry.key,
              child: PieceWidget(
                piece: entry.value,
                size: widget.squareSize,
                pieceAssets: widget.settings.pieceAssets,
                blindfoldMode: widget.settings.blindfoldMode,
              ),
            ),
        for (final entry in translatingPieces.entries)
          PositionedSquare(
            key: ValueKey('${entry.key}-${entry.value.$1.piece.kind.name}'),
            size: widget.squareSize,
            orientation: widget.data.orientation,
            squareId: entry.key,
            child: PieceTranslation(
              fromCoord: entry.value.$1.coord,
              toCoord: entry.value.$2.coord,
              orientation: widget.data.orientation,
              duration: widget.settings.animationDuration,
              onComplete: () {
                translatingPieces.remove(entry.key);
              },
              child: PieceWidget(
                piece: entry.value.$1.piece,
                size: widget.squareSize,
                pieceAssets: widget.settings.pieceAssets,
                blindfoldMode: widget.settings.blindfoldMode,
              ),
            ),
          ),
      ],
    );

    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        children: [
          // Consider using Listener instead as we don't control the drag start threshold with
          // GestureDetector (TODO)
          if (widget.data.interactableSide != InteractableSide.none &&
              !widget.settings.drawShape
                  .enable) // Disable moving pieces when drawing is enabled
            GestureDetector(
              // registering onTapDown is needed to prevent the panStart event to win the
              // competition too early
              // there is no need to implement the callback since we handle the selection login
              // in onPanDown; plus this way we avoid the timeout before onTapDown is called
              onTapDown: (TapDownDetails? details) {},
              onTapUp: _onTapUpPiece,
              onPanDown: _onPanDownPiece,
              onPanStart: _onPanStartPiece,
              onPanUpdate: _onPanUpdatePiece,
              onPanEnd: _onPanEndPiece,
              onPanCancel: _onPanCancelPiece,
              dragStartBehavior: DragStartBehavior.down,
              child: board,
            )
          else
            board,
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
    pieces = readFen(widget.data.fen);

    final rankDelta =
        widget.data.interactableSide == InteractableSide.white ? 0 : 4;
    for (var rank = 0; rank < 4; rank++) {
      for (var file = 0; file < 8; file++) {
        validDests.add(Coord(x: file, y: rank + rankDelta).squareId);
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
    if (widget.data.interactableSide == InteractableSide.none) {
      _dragAvatar?.cancel();
      _dragAvatar = null;
      _dragOrigin = null;
      selected = null;
    }
    if (oldBoard.data.fen == widget.data.fen) {
      _lastDrop = null;
      // as long as the fen is the same as before let's keep animations
      return;
    }
    translatingPieces = {};
    fadingPieces = {};
    final newPieces = readFen(widget.data.fen);
    final newOnSquare = <PositionedPiece>[];
    final missingOnSquare = <PositionedPiece>[];
    final animatedOrigins = <String>{};
    for (final s in allSquares) {
      if (s == _lastDrop?.from || s == _lastDrop?.to) {
        continue;
      }
      final oldP = pieces[s];
      final newP = newPieces[s];
      final squareCoord = Coord.fromSquareId(s);
      if (newP != null) {
        if (oldP != null) {
          if (newP != oldP) {
            missingOnSquare.add(
              PositionedPiece(piece: oldP, squareId: s, coord: squareCoord),
            );
            newOnSquare.add(
              PositionedPiece(piece: newP, squareId: s, coord: squareCoord),
            );
          }
        } else {
          newOnSquare.add(
            PositionedPiece(piece: newP, squareId: s, coord: squareCoord),
          );
        }
      } else if (oldP != null) {
        missingOnSquare
            .add(PositionedPiece(piece: oldP, squareId: s, coord: squareCoord));
      }
    }
    for (final newPiece in newOnSquare) {
      final fromP = newPiece.closest(
        missingOnSquare.where((m) => m.piece == newPiece.piece).toList(),
      );
      if (fromP != null) {
        translatingPieces[newPiece.squareId] = (fromP, newPiece);
        animatedOrigins.add(fromP.squareId);
      }
    }
    for (final m in missingOnSquare) {
      if (!animatedOrigins.contains(m.squareId)) {
        fadingPieces[m.squareId] = m.piece;
      }
    }
    _lastDrop = null;
    pieces = newPieces;
  }

  // returns the position of the square target during drag as a global offset
  Offset? _squareTargetGlobalOffset(Offset localPosition) {
    final coord = widget.localOffset2Coord(localPosition);
    if (coord == null) return null;
    final localOffset =
        coord.offset(widget.data.orientation, widget.squareSize);
    final box = context.findRenderObject()! as RenderBox;
    final tmpOffset = box.localToGlobal(localOffset);
    return Offset(
      tmpOffset.dx - widget.squareSize / 2,
      tmpOffset.dy - widget.squareSize / 2,
    );
  }

  void _onPanDownPiece(DragDownDetails? details) {
    if (details == null) return;

    final squareId = widget.localOffset2SquareId(details.localPosition);
    if (squareId == null) return;

    // if a movable piece is already selected, we want to allow castling by
    // selecting the king and then the rook, so `canMove` check must be false
    // to ensure we can select another piece
    if (_isMovable(squareId) &&
        (selected == null || !_canMove(selected!, squareId))) {
      setState(() {
        selected = squareId;
      });
    }
  }

  void _onPanStartPiece(DragStartDetails? details) {
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
    if (selected != null && dest != null && _canMove(selected!, dest)) {
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
      if (squareId != null && squareId != selected) {
        _tryMoveTo(squareId, drop: true);
      }
    }
    _dragAvatar?.end();
    _dragAvatar = null;
    setState(() {
      _dragOrigin = null;
      selected = null;
    });
  }

  void _onPanCancelPiece() {
    _dragAvatar?.cancel();
    _dragAvatar = null;
    setState(() {
      _dragOrigin = null;
    });
  }

  void _onTapUpPiece(TapUpDetails? details) {
    if (details == null) return;
    final squareId = widget.localOffset2SquareId(details.localPosition);
    if (squareId != null && squareId != selected) {
      _tryMoveTo(squareId);
    } else if (squareId != null && selected == squareId) {
      setState(() {
        selected = null;
      });
    }
  }

  bool _isMovable(SquareId squareId) {
    final piece = pieces[squareId];
    return piece != null &&
        (widget.data.interactableSide == InteractableSide.both ||
            widget.data.interactableSide.name == piece.color.name) &&
        widget.data.sideToMove == piece.color;
  }

  bool _canMove(SquareId orig, SquareId dest) {
    return orig != dest && validDests.contains(dest);
  }

  void _tryMoveTo(SquareId squareId, {bool drop = false}) {
    final selectedPiece = selected != null ? pieces[selected] : null;
    if (selectedPiece != null && _canMove(selected!, squareId)) {
      final move = Move(from: selected!, to: squareId);
      if (drop) {
        _lastDrop = move;
      }
      widget.onMove?.call(move);
    }
    setState(() {
      selected = null;
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

class PieceTranslation extends StatefulWidget {
  const PieceTranslation({
    required this.child,
    required this.fromCoord,
    required this.toCoord,
    required this.orientation,
    required this.onComplete,
    super.key,
    Duration? duration,
    Curve? curve,
  })  : duration = duration ?? const Duration(milliseconds: 150),
        curve = curve ?? Curves.easeInOutCubic;

  final Widget child;
  final Coord fromCoord;
  final Coord toCoord;
  final Side orientation;
  final void Function() onComplete;
  final Duration duration;
  final Curve curve;

  int get orientationFactor => orientation == Side.white ? 1 : -1;
  double get dx => -(toCoord.x - fromCoord.x).toDouble() * orientationFactor;
  double get dy => (toCoord.y - fromCoord.y).toDouble() * orientationFactor;

  @override
  State<PieceTranslation> createState() => _PieceTranslationState();
}

class _PieceTranslationState extends State<PieceTranslation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    })
    ..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(widget.dx, widget.dy),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}

class PieceFadeOut extends StatefulWidget {
  const PieceFadeOut({
    required this.piece,
    required this.size,
    required this.onComplete,
    required this.pieceAssets,
    super.key,
    this.blindfoldMode = false,
    Duration? duration,
    Curve? curve,
  })  : duration = duration ?? const Duration(milliseconds: 150),
        curve = curve ?? Curves.easeInQuad;

  final Piece piece;
  final double size;
  final PieceAssets pieceAssets;
  final bool blindfoldMode;
  final Duration duration;
  final Curve curve;
  final void Function() onComplete;

  @override
  State<PieceFadeOut> createState() => _PieceFadeOutState();
}

class _PieceFadeOutState extends State<PieceFadeOut>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    })
    ..forward();
  late final Animation<double> _animation = Tween<double>(
    begin: 1,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PieceWidget(
      piece: widget.piece,
      size: widget.size,
      opacity: _animation,
      pieceAssets: widget.pieceAssets,
      blindfoldMode: widget.blindfoldMode,
    );
  }
}
