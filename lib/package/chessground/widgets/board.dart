import 'dart:async';

import 'package:crea_chess/package/chessground/export.dart';
import 'package:crea_chess/package/chessground/widgets/animation.dart';
import 'package:crea_chess/package/chessground/widgets/board_annotation.dart';
import 'package:crea_chess/package/chessground/widgets/positioned_square.dart';
import 'package:crea_chess/package/chessground/widgets/promotion.dart';
import 'package:crea_chess/package/chessground/widgets/shape.dart';
import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// A chessboard widget.
///
/// This widget can be used to display a static board, a dynamic board that
/// shows a live game, or a full user interactable board.
class BoardWidget extends StatefulWidget {
  const BoardWidget({
    required this.size,
    required this.data,
    super.key,
    this.settings = const BoardSettings(),
    this.onMove,
    this.onPremove,
  });

  /// Number of ranks & files of the board
  final BoardSize size;

  /// Settings that control the theme, behavior and purpose of the board.
  final BoardSettings settings;

  /// Data that represents the current state of the board
  final BoardData data;

  /// Callback called after a move has been made.
  final void Function(CGMove, {bool? isDrop, bool? isPremove})? onMove;

  /// Callback called after a premove has been set/unset.
  ///
  /// If the callback is null, the board will not allow premoves.
  final void Function(CGMove?)? onPremove;

  Coord? localOffset2Coord(Offset offset, double squareSize) {
    final x = (offset.dx / squareSize).floor();
    final y = (offset.dy / squareSize).floor();
    final orientX = data.orientation == Side.black ? size.files - 1 - x : x;
    final orientY = data.orientation == Side.black ? y : size.ranks - 1 - y;
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

class _BoardState extends State<BoardWidget> {
  double squareSize = 0;
  Pieces pieces = {};
  late BoardColorScheme colorScheme;
  Map<String, (PositionedPiece, PositionedPiece)> translatingPieces = {};
  Map<String, CGPiece> fadingPieces = {};
  SquareId? selected;
  bool _shouldDeselectOnTapUp = false;
  CGMove? _promotionMove;
  CGMove? _lastDrop;
  Set<SquareId>? _premoveDests;
  _DragAvatar? _dragAvatar;
  SquareId? _dragOrigin;
  Shape? _shapeAvatar;

  @override
  Widget build(BuildContext context) {
    final moveDests = widget.settings.showValidMoves &&
            selected != null &&
            widget.data.validMoves != null
        ? widget.data.validMoves![selected!] ?? _emptyValidMoves
        : _emptyValidMoves;
    final premoveDests = widget.settings.showValidMoves
        ? _premoveDests ?? <SquareId>{}
        : <SquareId>{};
    final shapes = widget.data.shapes ?? _emptyShapes;
    final annotations = widget.data.annotations ?? _emptyAnnotations;
    final checkSquare = widget.data.isCheck ?? false ? _getKingSquare() : null;
    final premove = widget.data.premove;
        
    return LayoutBuilder(
      builder: (context, constraints) {
        final boardWidth = constraints.maxWidth;
        squareSize = boardWidth / widget.size.files;

        final Widget board = Stack(
          children: [
            if (widget.settings.enableCoordinates)
              widget.data.orientation == Side.white
                  ? colorScheme.whiteCoordBackground
                  : colorScheme.blackCoordBackground
            else
              colorScheme.background,
            if (widget.settings.showLastMove && widget.data.lastMove != null)
              for (final squareId in widget.data.lastMove!.squares)
                if (premove == null || !premove.hasSquare(squareId))
                  PositionedSquare(
                    key: ValueKey('$squareId-lastMove'),
                    size: squareSize,
                    orientation: widget.data.orientation,
                    coord: Coord.fromSquareId(squareId, boardSize: widget.size),
                    child: Highlight(
                      size: squareSize,
                      details: colorScheme.lastMove,
                    ),
                  ),
            if (premove != null &&
                widget.data.interactableSide != InteractableSide.none)
              for (final squareId in premove.squares)
                PositionedSquare(
                  key: ValueKey('$squareId-premove'),
                  size: squareSize,
                  orientation: widget.data.orientation,
                  coord: Coord.fromSquareId(squareId, boardSize: widget.size),
                  child: Highlight(
                    size: squareSize,
                    details:
                        HighlightDetails(solidColor: colorScheme.validPremoves),
                  ),
                ),
            if (selected != null)
              PositionedSquare(
                key: ValueKey('${selected!}-selected'),
                size: squareSize,
                orientation: widget.data.orientation,
                coord: Coord.fromSquareId(selected!, boardSize: widget.size),
                child: Highlight(
                  size: squareSize,
                  details: colorScheme.selected,
                ),
              ),
            for (final dest in moveDests)
              PositionedSquare(
                key: ValueKey('$dest-dest'),
                size: squareSize,
                orientation: widget.data.orientation,
                coord: Coord.fromSquareId(dest, boardSize: widget.size),
                child: MoveDest(
                  size: squareSize,
                  color: colorScheme.validMoves,
                  occupied: pieces.containsKey(dest),
                ),
              ),
            for (final dest in premoveDests)
              PositionedSquare(
                key: ValueKey('$dest-premove-dest'),
                size: squareSize,
                orientation: widget.data.orientation,
                coord: Coord.fromSquareId(dest, boardSize: widget.size),
                child: MoveDest(
                  size: squareSize,
                  color: colorScheme.validPremoves,
                  occupied: pieces.containsKey(dest),
                ),
              ),
            if (checkSquare != null)
              PositionedSquare(
                key: ValueKey('$checkSquare-check'),
                size: squareSize,
                orientation: widget.data.orientation,
                coord: Coord.fromSquareId(checkSquare, boardSize: widget.size),
                child: CheckHighlight(size: squareSize),
              ),
            for (final entry in fadingPieces.entries)
              PositionedSquare(
                key: ValueKey('${entry.key}-${entry.value.kind.name}-fading'),
                size: squareSize,
                orientation: widget.data.orientation,
                coord: Coord.fromSquareId(entry.key, boardSize: widget.size),
                child: PieceFadeOut(
                  duration: widget.settings.animationDuration,
                  piece: entry.value,
                  size: squareSize,
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
                  size: squareSize,
                  orientation: widget.data.orientation,
                  coord: Coord.fromSquareId(entry.key, boardSize: widget.size),
                  child: PieceWidget(
                    piece: entry.value,
                    size: squareSize,
                    pieceAssets: widget.settings.pieceAssets,
                    blindfoldMode: widget.settings.blindfoldMode,
                  ),
                ),
            for (final entry in translatingPieces.entries)
              PositionedSquare(
                key: ValueKey('${entry.key}-${entry.value.$1.piece.kind.name}'),
                size: squareSize,
                orientation: widget.data.orientation,
                coord: Coord.fromSquareId(entry.key, boardSize: widget.size),
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
                    size: squareSize,
                    pieceAssets: widget.settings.pieceAssets,
                    blindfoldMode: widget.settings.blindfoldMode,
                  ),
                ),
              ),
            for (final entry in annotations.entries)
              BoardAnnotation(
                key: ValueKey(
                  '${entry.key}-${entry.value.symbol}-${entry.value.color}',
                ),
                squareSize: squareSize,
                orientation: widget.data.orientation,
                squareId: entry.key,
                boardSize: widget.size,
                annotation: entry.value,
              ),
            for (final shape in shapes)
              ShapeWidget(
                shape: shape,
                boardSize: widget.size,
                boardSquareSize: squareSize,
                orientation: widget.data.orientation,
              ),
            if (_shapeAvatar != null)
              ShapeWidget(
                shape: _shapeAvatar!,
                boardSize: widget.size,
                boardSquareSize: squareSize,
                orientation: widget.data.orientation,
              ),
          ],
        );

        return SizedBox(
          width: boardWidth,
          height: squareSize * widget.size.ranks,
          child: Stack(
            children: [
              if (widget.data.interactableSide != InteractableSide.none &&
                  !widget.settings.drawShape
                      .enable) // Disable moving pieces when drawing is enabled
                GestureDetector(
                  // registering onTapDown is needed to prevent the panStart
                  // event to win the competition too early there is no need to
                  // implement the callback since we handle the selection login
                  // in onPanDown; plus this way we avoid the timeout before
                  //onTapDown is called
                  onTapDown: (TapDownDetails details) {},
                  onTapUp: _onTapUpPiece,
                  onPanDown: _onPanDownPiece,
                  onPanStart: _onPanStartPiece,
                  onPanUpdate: _onPanUpdatePiece,
                  onPanEnd: _onPanEndPiece,
                  onPanCancel: _onPanCancelPiece,
                  dragStartBehavior: DragStartBehavior.down,
                  child: board,
                )
              else if (widget.settings.drawShape.enable)
                GestureDetector(
                  onTapDown: (TapDownDetails? details) {},
                  onTapUp: _onTapUpShape,
                  onPanDown: _onPanDownShape,
                  onPanStart: _onPanStartShape,
                  onPanUpdate: _onPanUpdateShape,
                  onPanEnd: _onPanEndShape,
                  onPanCancel: _onPanCancelShape,
                  dragStartBehavior: DragStartBehavior.down,
                  child: board,
                )
              else
                board,
              if (_promotionMove != null && widget.data.sideToMove != null)
                PromotionSelector(
                  pieceAssets: widget.settings.pieceAssets,
                  move: _promotionMove!,
                  boardSize: widget.size,
                  squareSize: squareSize,
                  color: widget.data.sideToMove!,
                  orientation: widget.data.orientation,
                  onSelect: _onPromotionSelect,
                  onCancel: _onPromotionCancel,
                ),
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
    pieces = readFen(fen: widget.data.fen, boardSize: widget.size);
  }

  @override
  void dispose() {
    super.dispose();
    _dragAvatar?.cancel();
  }

  @override
  void didUpdateWidget(BoardWidget oldBoard) {
    super.didUpdateWidget(oldBoard);
    if (widget.data.interactableSide == InteractableSide.none) {
      _dragAvatar?.cancel();
      _dragAvatar = null;
      _dragOrigin = null;
      selected = null;
      _premoveDests = null;
    }
    if (oldBoard.data.sideToMove != widget.data.sideToMove) {
      _premoveDests = null;
      _promotionMove = null;
      if (widget.onPremove != null &&
          widget.data.premove != null &&
          widget.data.sideToMove?.name == widget.data.interactableSide.name) {
        Timer.run(() {
          if (mounted) _tryPlayPremove();
        });
      }
    }
    if (oldBoard.data.fen == widget.data.fen) {
      _lastDrop = null;
      // as long as the fen is the same as before let's keep animations
      return;
    }
    translatingPieces = {};
    fadingPieces = {};
    final newPieces = readFen(fen: widget.data.fen, boardSize: widget.size);
    final newOnSquare = <PositionedPiece>[];
    final missingOnSquare = <PositionedPiece>[];
    final animatedOrigins = <String>{};
    for (final s in widget.size.allSquareIds) {
      if (s == _lastDrop?.from || s == _lastDrop?.to) {
        continue;
      }
      final oldP = pieces[s];
      final newP = newPieces[s];
      final squareCoord = Coord.fromSquareId(s, boardSize: widget.size);
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

  SquareId? _getKingSquare() {
    for (final square in pieces.keys) {
      if (pieces[square]!.color == widget.data.sideToMove &&
          pieces[square]!.role == Role.king) {
        return square;
      }
    }
    return null;
  }

  // returns the position of the square target during drag as a global offset
  Offset? _squareTargetGlobalOffset(Offset localPosition) {
    final coord = widget.localOffset2Coord(localPosition, squareSize);
    if (coord == null) return null;
    final localOffset = coord.offset(widget.data.orientation, squareSize);
    final box = context.findRenderObject()! as RenderBox;
    final tmpOffset = box.localToGlobal(localOffset);
    return Offset(
      tmpOffset.dx - squareSize / 2,
      tmpOffset.dy - squareSize / 2,
    );
  }

  void _onPanDownPiece(DragDownDetails details) {
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId == null) return;

    // if a movable piece is already selected, we want to allow castling by
    // selecting the king and then the rook, so `canMove` check must be false
    // to ensure we can select another piece
    if (_isMovable(squareId) &&
        (selected == null || !_canMove(selected!, squareId))) {
      _shouldDeselectOnTapUp = selected == squareId;
      setState(() {
        selected = squareId;
      });
    }
    // same as above comment, but for premoves
    else if (_isPremovable(squareId) &&
        (selected == null || !_canPremove(selected!, squareId))) {
      _shouldDeselectOnTapUp = selected == squareId;
      widget.onPremove?.call(null);
      setState(() {
        selected = squareId;
        _premoveDests = premovesOf(
          squareId: squareId,
          boardSize: widget.size,
          pieces: pieces,
          canCastle: widget.settings.enablePremoveCastling,
        );
      });
    } else {
      widget.onPremove?.call(null);
      setState(() {
        _premoveDests = null;
      });
    }
  }

  void _onPanStartPiece(DragStartDetails details) {
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    final piece = squareId != null ? pieces[squareId] : null;
    final feedbackSize = squareSize * widget.settings.dragFeedbackSize;
    if (squareId != null &&
        piece != null &&
        (_isMovable(squareId) || _isPremovable(squareId))) {
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
    _dragAvatar?.updateSquareTarget(squareTargetOffset);
  }

  void _onPanEndPiece(_) {
    if (_dragAvatar != null) {
      final box = context.findRenderObject()! as RenderBox;
      final localPos = box.globalToLocal(_dragAvatar!._position);
      final squareId = widget.localOffset2SquareId(
        localPos,
        squareSize,
      );
      if (squareId != null && squareId != selected) {
        _tryMoveTo(squareId, drop: true);
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

  void _onTapUpPiece(TapUpDetails details) {
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId != null && squareId != selected) {
      _tryMoveTo(squareId);
    } else if (squareId != null &&
        selected == squareId &&
        _shouldDeselectOnTapUp) {
      _shouldDeselectOnTapUp = false;
      setState(() {
        selected = null;
        _premoveDests = null;
      });
    }
  }

  void _onPanDownShape(DragDownDetails details) {
    if (widget.settings.drawShape.enable == false) return;
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId == null) return;
    setState(() {
      // Initialize shapeAvatar on tap down (Analogous to website)
      _shapeAvatar = Circle(
        color: widget.settings.drawShape.newShapeColor,
        orig: Coord.fromSquareId(squareId, boardSize: widget.size),
      );
    });
  }

  void _onPanStartShape(DragStartDetails details) {
    if (_shapeAvatar == null ||
        widget.settings.drawShape.enable == false) return;
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId == null) return;
    setState(() {
      // Update shapeAvatar on starting pan
      _shapeAvatar = _shapeAvatar!.newDest(
        Coord.fromSquareId(squareId, boardSize: widget.size),
      );
    });
  }

  void _onPanUpdateShape(DragUpdateDetails details) {
    if (_shapeAvatar == null ||
        widget.settings.drawShape.enable == false) return;
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId == null ||
        (_shapeAvatar! is Arrow &&
            squareId == (_shapeAvatar! as Arrow).dest.squareId)) {
      return;
    }
    setState(() {
      // Update shapeAvatar on panning once a new square is reached
      _shapeAvatar = _shapeAvatar!.newDest(
        Coord.fromSquareId(squareId, boardSize: widget.size),
      );
    });
  }

  void _onPanEndShape(_) {
    if (_shapeAvatar == null || widget.settings.drawShape.enable == false) {
      return;
    }
    widget.settings.drawShape.onCompleteShape?.call(_shapeAvatar!);
    setState(() {
      _shapeAvatar = null;
    });
  }

  void _onPanCancelShape() {
    setState(() {
      _shapeAvatar = null;
    });
  }

  void _onTapUpShape(TapUpDetails details) {
    if (widget.settings.drawShape.enable == false) return;
    final squareId = widget.localOffset2SquareId(
      details.localPosition,
      squareSize,
    );
    if (squareId == null) return;
    widget.settings.drawShape.onCompleteShape?.call(
      Circle(
        color: widget.settings.drawShape.newShapeColor,
        orig: Coord.fromSquareId(squareId, boardSize: widget.size),
      ),
    );
    setState(() {
      _shapeAvatar = null;
    });
  }

  void _onPromotionSelect(CGMove move, CGPiece promoted) {
    setState(() {
      pieces[move.to] = promoted;
      _promotionMove = null;
    });
    widget.onMove?.call(move.withPromotion(promoted.role), isDrop: true);
  }

  void _onPromotionCancel(CGMove move) {
    setState(() {
      pieces = readFen(fen: widget.data.fen, boardSize: widget.size);
      _promotionMove = null;
    });
  }

  void _openPromotionSelector(CGMove move) {
    setState(() {
      final pawn = pieces.remove(move.from);
      pieces[move.to] = pawn!;
      _promotionMove = move;
    });
  }

  bool _isMovable(SquareId squareId) {
    final piece = pieces[squareId];
    return piece != null &&
        (widget.data.interactableSide == InteractableSide.both ||
            widget.data.interactableSide.name == piece.color.name) &&
        widget.data.sideToMove == piece.color;
  }

  bool _canMove(SquareId orig, SquareId dest) {
    final validDests = widget.data.validMoves?[orig];
    return orig != dest && validDests != null && validDests.contains(dest);
  }

  bool _isPremovable(SquareId squareId) {
    final piece = pieces[squareId];
    return piece != null &&
        (widget.onPremove != null &&
            widget.data.interactableSide.name == piece.color.name &&
            widget.data.sideToMove != piece.color);
  }

  bool _canPremove(SquareId orig, SquareId dest) {
    return orig != dest &&
        _isPremovable(orig) &&
        premovesOf(
          squareId: orig,
          boardSize: widget.size,
          pieces: pieces,
          canCastle: widget.settings.enablePremoveCastling,
        ).contains(dest);
  }

  bool _isPromoMove(CGPiece piece, SquareId targetSquareId) {
    final rank = targetSquareId[1];
    return piece.role == Role.pawn && (rank == '1' || rank == '8');
  }

  void _tryMoveTo(SquareId squareId, {bool drop = false}) {
    final selectedPiece = selected != null ? pieces[selected] : null;
    if (selectedPiece != null && _canMove(selected!, squareId)) {
      final move = CGMove(from: selected!, to: squareId);
      if (drop) {
        _lastDrop = move;
      }
      if (_isPromoMove(selectedPiece, squareId)) {
        if (widget.settings.autoQueenPromotion) {
          widget.onMove?.call(move.withPromotion(Role.queen), isDrop: drop);
        } else {
          _openPromotionSelector(move);
        }
      } else {
        widget.onMove?.call(move, isDrop: drop);
      }
    } else if (selectedPiece != null && _canPremove(selected!, squareId)) {
      widget.onPremove?.call(CGMove(from: selected!, to: squareId));
    }
    setState(() {
      selected = null;
      _premoveDests = null;
    });
  }

  void _tryPlayPremove() {
    final premove = widget.data.premove;
    if (premove == null) {
      return;
    }
    final fromPiece = pieces[premove.from];
    if (fromPiece != null && _canMove(premove.from, premove.to)) {
      if (_isPromoMove(fromPiece, premove.to)) {
        if (widget.settings.autoQueenPromotion ||
            widget.settings.autoQueenPromotionOnPremove) {
          widget.onMove?.call(
            premove.withPromotion(Role.queen),
            isPremove: true,
          );
        } else {
          _openPromotionSelector(premove);
        }
      } else {
        widget.onMove?.call(premove, isPremove: true);
      }
    }
    widget.onPremove?.call(null);
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

const ISet<String> _emptyValidMoves = ISetConst({});
const ISet<Shape> _emptyShapes = ISetConst({});
const IMap<SquareId, Annotation> _emptyAnnotations = IMapConst({});
