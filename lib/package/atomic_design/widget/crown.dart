import 'dart:math';

import 'package:crea_chess/package/atomic_design/animation/fireworks.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';

class Crown extends StatefulWidget {
  const Crown({super.key});

  @override
  State<Crown> createState() => _CrownState();

  static const double size = CCWidgetSize.xxsmall;
}

class _CrownState extends State<Crown> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Crown.size,
      width: Crown.size,
      child: Stack(
        children: [
          Center(
            child: CustomPaint(
              painter: FireworksPainter(
                controller: _controller,
                fireworks: const [
                  FireworkData(
                    particlesWidth: 2,
                    startCoef: 0.1,
                    endCoef: 0.9,
                  ),
                  FireworkData(
                    color: Colors.blue,
                    particlesWidth: 2,
                    startCoef: 0.4,
                    rotateAngle: pi / 8,
                  ),
                  FireworkData(
                    color: Colors.yellow,
                    particlesCount: 16,
                    particlesWidth: 2,
                    startCoef: 0.5,
                    rotateAngle: pi / 16,
                  ),
                ],
              ),
              size: const Size(Crown.size, Crown.size),
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: -.5,
              child: const Text('👑'),
            ),
          ),
        ],
      ),
    );
  }
}
