import 'dart:math' as math;

import 'package:crea_chess/package/chessground/models.dart';
import 'package:flutter/widgets.dart';

/// Widget that displays a chess piece
class PieceWidget extends StatelessWidget {
  const PieceWidget({
    required this.piece,
    required this.size,
    required this.pieceAssets,
    super.key,
    this.opacity,
    this.blindfoldMode = false,
  });

  /// Specifies the role and color of the piece
  final CGPiece piece;

  /// Size of the board square the piece will occupy
  final double size;

  /// CGPiece set
  final PieceAssets pieceAssets;

  /// Pieces are hidden in blindfold mode
  final bool blindfoldMode;

  /// Use this value to animate the opacity of the piece
  final Animation<double>? opacity;

  @override
  Widget build(BuildContext context) {
    if (blindfoldMode) {
      return SizedBox(width: size, height: size);
    }

    final asset = pieceAssets[piece.kind]!;
    final deviceRatio = MediaQuery.devicePixelRatioOf(context);
    // the ratio is defined by the resolution aware image assets defined in
    // assets/piece_sets/
    // that's why 4 is the maximum ratio
    final ratio = math.min(deviceRatio.ceilToDouble(), 4);
    final cacheSize = (size * ratio).ceil();
    return Image.asset(
      asset.assetName,
      bundle: asset.bundle,
      package: asset.package,
      opacity: opacity,
      width: size,
      height: size,
      cacheWidth: cacheSize,
      cacheHeight: cacheSize,
    );
  }
}
