import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../animators/fade_animator.dart';
import '../../../../theme/app_colors.dart';
import 'discovery_pass.dart';

class PassModel {
  final Color color;
  final Image imageOne;
  final Image imageTwo;
  final String title;

  PassModel({
    required this.color,
    required this.imageOne,
    required this.imageTwo,
    required this.title,
  });
}

class NeoPassesAnimation extends StatefulWidget {
  const NeoPassesAnimation({super.key});

  @override
  State<NeoPassesAnimation> createState() => _NeoPassesAnimationState();
}

class _NeoPassesAnimationState extends State<NeoPassesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scaleAnimation;

  late Animation<double> _firstCardTranslationAnimation;
  late Animation<double> _secondCardTranslationAnimation;
  late Animation<double> _fourthCardTranslationAnimation;

  PassModel epicurePass = PassModel(
    color: Colors.black,
    imageOne: Assets.pngs.loungeOne.image(),
    imageTwo: Assets.pngs.loungeTwo.image(),
    title: 'Epicure Passes',
  );

  PassModel healthPass = PassModel(
    color: AppColors.success[500]!,
    imageOne: Assets.pngs.cultFir.image(),
    imageTwo: Assets.pngs.tata1mg.image(),
    title: 'Health and Wellness Passess',
  );

  PassModel exclusiveLounges = PassModel(
    color: AppColors.primary[500]!,
    imageOne: Assets.pngs.marriot.image(),
    imageTwo: Assets.pngs.theLeela.image(),
    title: 'Exclusive Lounges',
  );

  PassModel golfClubPass = PassModel(
    color: AppColors.alert[500]!,
    imageOne: Assets.pngs.golfOne.image(),
    imageTwo: Assets.pngs.golfTwo.image(),
    title: 'Golf Club Passes',
  );

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
    return FadeAnimator(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              MediaQuery.of(context).size.width * 0.05,
              250,
            ),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(
                      0,
                      _firstCardTranslationAnimation.value,
                    ),
                    child: DiscoveryPass(
                      color: exclusiveLounges.color,
                      imageOne: exclusiveLounges.imageOne,
                      imageTwo: exclusiveLounges.imageTwo,
                      title: exclusiveLounges.title,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      0,
                      _secondCardTranslationAnimation.value,
                    ),
                    child: DiscoveryPass(
                      color: healthPass.color,
                      imageOne: healthPass.imageOne,
                      imageTwo: healthPass.imageTwo,
                      title: healthPass.title,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      0,
                      _fourthCardTranslationAnimation.value,
                    ),
                    child: DiscoveryPass(
                      color: golfClubPass.color,
                      imageOne: golfClubPass.imageOne,
                      imageTwo: golfClubPass.imageTwo,
                      title: golfClubPass.title,
                    ),
                  ),
                  DiscoveryPass(
                    color: epicurePass.color,
                    imageOne: epicurePass.imageOne,
                    imageTwo: epicurePass.imageTwo,
                    title: epicurePass.title,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    _firstCardTranslationAnimation = Tween<double>(
      begin: 0.0,
      end: -200.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _secondCardTranslationAnimation = Tween<double>(
      begin: 0.0,
      end: -100.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _fourthCardTranslationAnimation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _animationController.forward();
  }
}
