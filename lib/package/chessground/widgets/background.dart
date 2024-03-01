import 'dart:math';
import 'dart:ui' as ui;

import 'package:crea_chess/package/unichess/unichess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// BoardWidget background.
abstract class Background extends StatelessWidget {
  const Background({
    required this.lightSquare,
    required this.darkSquare,
    required this.boardSize,
    super.key,
    this.coordinates = false,
    this.orientation = Side.white,
  });

  final Color lightSquare;
  final Color darkSquare;
  final BoardSize boardSize;
  final bool coordinates;
  final Side orientation;
}

class SolidColorBackground extends Background {
  const SolidColorBackground({
    required super.lightSquare,
    required super.darkSquare,
    required super.boardSize,
    super.coordinates,
    super.orientation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: List.generate(
          boardSize.ranks,
          (rank) => Expanded(
            child: Row(
              children: List.generate(
                boardSize.files,
                (file) => Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: (rank + file).isEven ? lightSquare : darkSquare,
                    child: coordinates
                        ? Coordinate(
                            boardSize: boardSize,
                            rank: rank,
                            file: file,
                            orientation: orientation,
                            color:
                                (rank + file).isEven ? darkSquare : lightSquare,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBackground extends Background {
  const ImageBackground({
    required super.lightSquare,
    required super.darkSquare,
    required this.image,
    required super.boardSize,
    super.coordinates,
    super.orientation,
    super.key,
  });

  final AssetImage image;

  SolidColorBackground get solid => SolidColorBackground(
        lightSquare: lightSquare,
        darkSquare: darkSquare,
        boardSize: boardSize,
        coordinates: coordinates,
        orientation: orientation,
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boardWidth = constraints.maxWidth;
        final squareSize = boardWidth / boardSize.files;
        final boardHeight = squareSize * boardSize.ranks;

        return SizedBox.expand(
          child: Stack(
            children: [
              FutureBuilder<ui.Image>(
                future: _loadBackground(
                  assetPath: image.assetName,
                  squareSize: squareSize,
                  boardSize: boardSize,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return solid;
                    // ignore: no_default_cases
                    default:
                      if (snapshot.hasError) {
                        return solid;
                      } else {
                        return CustomPaint(
                          painter: _BackgroundPainter(
                            image: snapshot.data!,
                            boardWidth: boardWidth,
                            boardSize: boardSize,
                          ),
                          child: SizedBox(
                            width: boardWidth,
                            height: boardHeight,
                          ),
                        );
                      }
                  }
                },
              ),
              if (coordinates)
                Column(
                  children: List.generate(
                    boardSize.ranks,
                    (rank) => Expanded(
                      child: Row(
                        children: List.generate(
                          boardSize.files,
                          (file) => Expanded(
                            child: SizedBox.expand(
                              child: Coordinate(
                                boardSize: boardSize,
                                rank: rank,
                                file: file,
                                orientation: orientation,
                                color: (rank + file).isEven
                                    ? darkSquare
                                    : lightSquare,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({
    required this.image,
    required this.boardWidth,
    required this.boardSize,
  });

  final ui.Image image;
  final double boardWidth;
  final BoardSize boardSize;

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final squareSize = boardWidth / boardSize.files;
    final boardHeight = squareSize * boardSize.ranks;

    // The board assets are 8x8 boards
    final imageSize = squareSize * 8;

    final paint = Paint();

    for (var left = 0.0; left < boardWidth; left += imageSize) {
      final width = min(imageSize, boardWidth - left);
      for (var top = 0.0; top < boardHeight; top += imageSize) {
        final height = min(imageSize, boardHeight - top);

        // The ceil and floor method avoid the blank pixels under and at the
        // bottom of the image
        final source = Rect.fromLTWH(
          0,
          0,
          width.floor().toDouble(),
          height.floor().toDouble(),
        );
        final dest = Rect.fromLTWH(
          left,
          top,
          width.ceil().toDouble(),
          height.ceil().toDouble(),
        );
        canvas.drawImageRect(image, source, dest, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

Future<ui.Image> _loadBackground({
  required String assetPath,
  required double squareSize,
  required BoardSize boardSize,
}) async {
  final data = await rootBundle.load(assetPath);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: (squareSize * boardSize.ranks).toInt(),
    targetWidth: (squareSize * boardSize.files).toInt(),
  );
  final frame = await codec.getNextFrame();
  return frame.image;
}

class Coordinate extends StatelessWidget {
  const Coordinate({
    required this.boardSize,
    required this.rank,
    required this.file,
    required this.color,
    required this.orientation,
    super.key,
  });

  final BoardSize boardSize;
  final int rank;
  final int file;
  final Color color;
  final Side orientation;

  @override
  Widget build(BuildContext context) {
    final coordStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: color,
      fontFamily: 'Roboto',
    );
    return Stack(
      children: [
        if (file == boardSize.files - 1)
          Align(
            alignment: Alignment.topRight,
            child: Text(
              orientation == Side.white
                  ? '${boardSize.ranks - rank}'
                  : '${rank + 1}',
              style: coordStyle,
            ),
          ),
        if (rank == boardSize.ranks - 1)
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              orientation == Side.white
                  ? String.fromCharCode(97 + file)
                  : String.fromCharCode(97 + boardSize.files - file),
              style: coordStyle,
            ),
          ),
      ],
    );
  }
}
