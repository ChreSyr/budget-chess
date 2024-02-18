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

class FireworksExplosion extends StatefulWidget {
  const FireworksExplosion({
    required this.size,
    required this.fireworks,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    super.key,
  });

  final int size;
  final List<FireworkData> fireworks;
  final Duration duration;
  final Duration delay;

  @override
  State<FireworksExplosion> createState() => _FireworksExplosionState();
}

class _FireworksExplosionState extends State<FireworksExplosion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    Future.delayed(widget.delay, _controller.forward);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FireworksPainter(
        controller: _controller,
        fireworks: widget.fireworks,
        radius: widget.size / 2,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _FireworksPainter extends CustomPainter {
  _FireworksPainter({
    required this.controller,
    required this.fireworks,
    required this.radius,
  }) : super(repaint: controller);

  final AnimationController controller;
  final List<FireworkData> fireworks;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    for (final firework in fireworks) {
      final paint = Paint()
        ..color = firework.color
        ..strokeWidth = firework.particlesWidth
        ..strokeCap = StrokeCap.round;

      final centerX = size.width / 2;
      final centerY = size.height / 2;

      final start = radius * firework.startCoef;
      final end = radius * firework.endCoef;
      final pathLength = end - start;

      const delay = 0.3;
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
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
