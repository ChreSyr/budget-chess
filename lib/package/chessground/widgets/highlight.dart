import 'dart:ui';

import 'package:crea_chess/package/chessground/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Highlight extends StatelessWidget {
  const Highlight({
    required this.details,
    required this.size,
    super.key,
  });

  final HighlightDetails details;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (details.image != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: details.image!,
            fit: BoxFit.cover,
          ),
        ),
        color: details.solidColor,
      );
    }
    return Container(
      width: size,
      height: size,
      color: details.solidColor,
    );
  }
}

class CheckHighlight extends StatelessWidget {
  const CheckHighlight({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size),
              gradient: const RadialGradient(
                radius: 0.6,
                colors: [
                  Color(0xFFFF0000),
                  Color(0xFFE70000),
                  Color(0x00A90000),
                  Color(0x009E0000),
                ],
                stops: [0.0, 0.25, 0.90, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoveDest extends StatelessWidget {
  const MoveDest({
    required this.color,
    required this.size,
    super.key,
    this.occupied = false,
  });

  final Color color;
  final double size;
  final bool occupied;

  @override
  Widget build(BuildContext context) {
    return occupied
        ? OccupiedMoveDest(color: color, size: size)
        : SizedBox.square(
            dimension: size,
            child: Padding(
              padding: EdgeInsets.all(size / 3),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
  }
}

class OccupiedMoveDest extends StatelessWidget {
  const OccupiedMoveDest({
    required this.color,
    required this.size,
    super.key,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _OccupiedMoveDestPainter(color),
      ),
    );
  }
}

class _OccupiedMoveDestPainter extends CustomPainter {
  _OccupiedMoveDestPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width / 5
      ..style = PaintingStyle.stroke;

    canvas
      ..clipRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width - (size.width / 3),
        paint,
      );
  }

  @override
  bool shouldRepaint(_OccupiedMoveDestPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
