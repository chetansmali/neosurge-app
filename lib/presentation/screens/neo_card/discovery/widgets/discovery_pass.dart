import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiscoveryPass extends StatelessWidget {
  const DiscoveryPass({
    super.key,
    required this.color,
    required this.title,
    required this.imageOne,
    required this.imageTwo,
  });

  final Color color;
  final String title;
  final Image imageOne;
  final Image imageTwo;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width * 0.9,
        90,
      ),
      painter: _PassDesign(
        color: color,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 90,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: imageOne.image,
                  ),
                  Positioned(
                    left: 30,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: imageTwo.image,
                    ),
                  ),
                ],
              ),
              const Gap(40),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PassDesign extends CustomPainter {
  final Color color;

  _PassDesign({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Path for background design
    Path path = Path();

    // Build the path for rectangle

    path.moveTo(10, 0);
    path.lineTo(size.width, 0);

    // 6 side curve
    var previousCurveY1 = 7.5;
    var previousCurveY2 = 15.0;

    for (int i = 0; i < 6; i++) {
      path.quadraticBezierTo(
        size.width - 8,
        previousCurveY1,
        size.width,
        previousCurveY2,
      );

      previousCurveY1 += 15.0;
      previousCurveY2 += 15.0;
    }

    path.lineTo(size.width, size.height);

    // Bottom left corner curve
    path.lineTo(10, size.height);
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - 10,
    );

    // Top left corner curve
    path.lineTo(0, 10);
    path.quadraticBezierTo(
      0,
      0,
      10,
      0,
    );

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
