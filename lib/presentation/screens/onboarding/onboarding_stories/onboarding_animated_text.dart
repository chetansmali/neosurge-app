import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../animators/fade_animator.dart';

class OnboardingAnimatedText extends StatelessWidget {
  const OnboardingAnimatedText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _TextFadeAnimator(
      key: UniqueKey(),
      title: title,
      description: description,
    );
  }
}

class _TextFadeAnimator extends StatelessWidget {
  const _TextFadeAnimator({
    Key? key,
    required this.description,
    required this.title,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      key: UniqueKey(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(10),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
