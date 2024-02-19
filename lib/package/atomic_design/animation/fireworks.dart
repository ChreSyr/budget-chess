import 'dart:math';

import 'package:flutter/material.dart';

class FireworkData {
  const FireworkData({
    this.color = Colors.red,
    this.particlesCount = 8,
    this.particlesWidth = 1,
    this.startCoef = 0,
    this.endCoef = 1,
    this.rotateAngle = 0,
  })  : assert(0 <= startCoef && startCoef <= 1),
        assert(0 <= endCoef && endCoef <= 1);

  final Color color;
  final int particlesCount;
  final double particlesWidth;

  /// The start distance from the center, relatively to the radius.
  /// Between 1 and 0.
  final double startCoef;

  /// The end distance from the center, relatively to the radius.
  /// Between 1 and 0.
  final double endCoef;

  /// An angle to slighly rotate the firework direction, in radians.
  final double rotateAngle;
}

/// Painter for FireworkData, to be used with CustomPaint.
///
/// exemple :
/// ```
///   CustomPaint(
///     painter: FireworksPainter(
///       controller: controller,
///       fireworks: fireworks,
///     size: const Size(100, 100),
///     ),
///   ),
/// ```
class FireworksPainter extends CustomPainter {
  FireworksPainter({
    required this.controller,
    required this.fireworks,
  }) : super(repaint: controller);

  final AnimationController controller;
  final List<FireworkData> fireworks;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = min(centerX, centerY);

    // delay before the particles start to shrink
    const delay = 0.3;

    for (final firework in fireworks) {
      final paint = Paint()
        ..color = firework.color
        ..strokeWidth = firework.particlesWidth
        ..strokeCap = StrokeCap.round;

      final start = radius * firework.startCoef;
      final end = radius * firework.endCoef;
      final pathLength = end - start;

      final startLength = start +
          (controller.value > delay
                  ? sqrt((controller.value - delay) / (1 - delay))
                  : 0) *
              pathLength;
      final endLength = start + sqrt(controller.value) * pathLength;

      if (startLength == endLength) continue;

      for (var i = 0; i < firework.particlesCount; i++) {
        final angle =
            2 * pi * i / firework.particlesCount + firework.rotateAngle;

        final startX = centerX + startLength * cos(angle);
        final startY = centerY + startLength * sin(angle);

        final endX = centerX + endLength * cos(angle);
        final endY = centerY + endLength * sin(angle);

        canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
