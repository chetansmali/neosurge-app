import 'package:flutter/material.dart';
import 'dart:math' as math;

class PercentageCircle extends StatelessWidget {
  final double percentage;
  final double size;

  const PercentageCircle({Key? key, required this.percentage, this.size = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CircleBorderPainter(percentage: percentage),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: Text('${(percentage * 100).toInt()}%'),
      ),
    );
  }
}

class _CircleBorderPainter extends CustomPainter {
  final double percentage;

  _CircleBorderPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width,
      height: size.height,
    );

    // Draw the white part of the circle
    paint.color = const Color(0xFFE7FAEF);
    canvas.drawArc(rect, 2 * math.pi * percentage - math.pi / 2,
        2 * math.pi * (1 - percentage), false, paint);

    // Draw the green part of the circle
    paint.color = const Color(0xFF12C863);
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * percentage, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
