import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';

class NeoTransactionAnimation extends StatefulWidget {
  const NeoTransactionAnimation({super.key});

  @override
  State<NeoTransactionAnimation> createState() =>
      _NeoTransactionAnimationState();
}

class _NeoTransactionAnimationState extends State<NeoTransactionAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _mockupScaleAnimation;
  late Animation<double> _mockupTranslationAnimation;
  late Animation<double> _cardsRotationAnimation;
  late Animation<double> _cardsTranslationAnimation;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0.0,
            -(_mockupTranslationAnimation.value),
          ),
          child: Transform.scale(
            scale: _mockupScaleAnimation.value,
            child: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Transform.translate(
                    offset: Offset(
                      -(_cardsTranslationAnimation.value),
                      0.0,
                    ),
                    child: Transform.rotate(
                      angle: -(_cardsRotationAnimation.value),
                      child: Assets.svgs.apexCard.svg(
                        height: 160,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      (_cardsTranslationAnimation.value),
                      0.0,
                    ),
                    child: Transform.rotate(
                      angle: (_cardsRotationAnimation.value),
                      child: Assets.pngs.luminaCard.image(
                        height: 160,
                      ),
                    ),
                  ),
                  Assets.pngs.mockup.image(
                    height: 320,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _mockupScaleAnimation = Tween<double>(
      begin: 2.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    _mockupTranslationAnimation = Tween<double>(
      begin: -160.0,
      end: 80.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    _cardsRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.3,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _cardsTranslationAnimation = Tween<double>(
      begin: 0.0,
      end: 90.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _animationController.forward();
  }
}
