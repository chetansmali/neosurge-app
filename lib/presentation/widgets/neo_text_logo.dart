import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../animators/slide_fade_animator.dart';
import 'gradient_text.dart';
import 'neo_logo.dart';

class NeoTextLogo extends StatelessWidget {
  const NeoTextLogo({
    Key? key,
    this.neoColor,
  }) : super(key: key);

  final Color? neoColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const NeoLogo(),
        const Gap(4),
        Text(
          'neo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 42,
            color: neoColor,
          ),
        ),
        const SlideFadeAnimator(
          child: GradientText(
            'surge',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF39AAF3),
                Color(0xFF326CF9),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
