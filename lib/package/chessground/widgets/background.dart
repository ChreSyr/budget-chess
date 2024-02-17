import 'package:crea_chess/package/dartchess/export.dart';
import 'package:flutter/widgets.dart';

/// BoardWidget background.
abstract class Background extends StatelessWidget {
  const Background({
    required this.lightSquare,
    required this.darkSquare,
    super.key,
    this.coordinates = false,
    this.orientation = Side.white,
  });

  final bool coordinates;
  final Side orientation;
  final Color lightSquare;
  final Color darkSquare;
}

class SolidColorBackground extends Background {
  const SolidColorBackground({
    required super.lightSquare,
    required super.darkSquare,
    super.key,
    super.coordinates,
    super.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: List.generate(
          8,
          (rank) => Expanded(
            child: Row(
              children: List.generate(
                8,
                (file) => Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: (rank + file).isEven ? lightSquare : darkSquare,
                    child: coordinates
                        ? Coordinate(
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
    super.key,
    super.coordinates,
    super.orientation,
  });

  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Image(image: image),
          if (coordinates)
            Column(
              children: List.generate(
                8,
                (rank) => Expanded(
                  child: Row(
                    children: List.generate(
                      8,
                      (file) => Expanded(
                        child: SizedBox.expand(
                          child: Coordinate(
                            rank: rank,
                            file: file,
                            orientation: orientation,
                            color:
                                (rank + file).isEven ? darkSquare : lightSquare,
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
  }
}

class Coordinate extends StatelessWidget {
  const Coordinate({
    required this.rank,
    required this.file,
    required this.color,
    required this.orientation,
    super.key,
  });

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
        if (file == 7)
          Align(
            alignment: Alignment.topRight,
            child: Text(
              orientation == Side.white ? '${8 - rank}' : '${rank + 1}',
              style: coordStyle,
            ),
          ),
        if (rank == 7)
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              orientation == Side.white
                  ? String.fromCharCode(97 + file)
                  : String.fromCharCode(97 + 7 - file),
              style: coordStyle,
            ),
          ),
      ],
    );
  }
}
