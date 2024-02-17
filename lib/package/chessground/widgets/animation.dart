import 'package:crea_chess/package/chessground/models.dart';
import 'package:crea_chess/package/chessground/widgets/piece.dart';
import 'package:crea_chess/package/dartchess/export.dart';
import 'package:flutter/widgets.dart';

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

  final CGPiece piece;
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
