import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../widgets/amount_widget.dart';

class LamfBannerTotal extends StatelessWidget {
  const LamfBannerTotal({
    super.key,
    required this.cashWithdrawn,
    required this.cashAvailable,
    required this.cashSanctioned,
  });
  final double cashWithdrawn, cashAvailable, cashSanctioned;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF133C6B),
            Color(0xFF121517),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const _LAMFBannerIndicatorCircle(
                              color: Color(0xFF2E8EFF)),
                          const Gap(4.0),
                          Expanded(
                            child: Text(
                              'Withdrawn cash',
                              style: baseTextStyle10400.copyWith(
                                  color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      AmountWidget(
                          amount: cashWithdrawn,
                          style:
                              baseTextStyle12500.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                const Gap(8.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const _LAMFBannerIndicatorCircle(color: Colors.white),
                          const Gap(4.0),
                          Expanded(
                            child: Text(
                              'Sanctioned cash',
                              style: baseTextStyle10400.copyWith(
                                  color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      AmountWidget(
                          amount: cashSanctioned,
                          style:
                              baseTextStyle12500.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(8),
            SizedBox(
              height: 120.0,
              width: 120.0,
              child: _CashAvailableCircle(
                percentage: cashWithdrawn / cashSanctioned,
                cashAvailable: cashAvailable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CashAvailableCircle extends StatelessWidget {
  final double percentage;
  final double cashAvailable;

  const _CashAvailableCircle({
    required this.percentage,
    required this.cashAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(120, 120),
      painter: _CircleBorderPainter(percentage: percentage),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cash available',
                style: baseTextStyle10400.copyWith(color: Colors.white)),
            AmountWidget(
                amount: cashAvailable,
                style: baseTextStyle18500.copyWith(color: Colors.white)),
          ],
        ),
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

    paint.color = const Color(0xFFE7FAEF);
    canvas.drawArc(rect, 2 * pi * percentage - pi / 2,
        2 * pi * (1 - percentage), false, paint);

    paint.color = const Color(0xFF2E8EFF);
    canvas.drawArc(rect, -pi / 2, 2 * pi * percentage, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _LAMFBannerIndicatorCircle extends StatelessWidget {
  const _LAMFBannerIndicatorCircle({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      height: 10,
      width: 10,
    );
  }
}
