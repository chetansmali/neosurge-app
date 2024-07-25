import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/neo_card/discovery/discovery_animation_cubit.dart';

class CardsAnimation extends StatefulWidget {
  const CardsAnimation({super.key});

  @override
  State<CardsAnimation> createState() => _CardsAnimationState();
}

class _CardsAnimationState extends State<CardsAnimation>
    with TickerProviderStateMixin {
  late Offset _apexCardInitialPosition;
  late Offset _luminaCardInitialPosition;

  late AnimationController _animationController;

  late Animation<double> _apexCardFirstSlideTransitionAnimation;
  late Animation<double> _luminaCardFirstSlideTransitionAnimation;
  late Animation<double> _apexCardFirstSlideScaleAnimation;
  late Animation<double> _luminaCardFirstSlideScaleAnimation;

  late Animation<double> _apexCardSecondSlideTransitionAnimation;
  late Animation<double> _luminaCardSecondSlideTransitionAnimation;
  late Animation<double> _apexCardSecondSlideScaleAnimation;
  late Animation<double> _luminaCardSecondSlideScaleAnimation;
  late Animation<double> _apexCardSecondSlideRotationAnimation;

  late Animation<double> _apexCardThirdSlideTransitionAnimation;
  late Animation<double> _luminaCardThirdSlideTransitionAnimation;
  late Animation<double> _apexCardThirdSlideScaleAnimation;
  late Animation<double> _luminaCardThirdSlideScaleAnimation;
  late Animation<double> _apexCardThirdSlideRotationAnimation;
  late Animation<double> _luminaCardThirdSlideRotationAnimation;

  late Animation<double> _apexCardFourthSlideTransitionAnimation;
  late Animation<double> _luminaCardFourthSlideTransitionAnimation;
  late Animation<double> _apexCardFourthSlideScaleAnimation;
  late Animation<double> _apexCardFourthSlideRotationAnimation;
  late Animation<double> _luminaCardFourthSlideRotationAnimation;
  late Animation<double> _voucherSlideTransitionAnimation;
  late Animation<double> _giftBoxSlideTransitionAnimation;
  late Animation<double> _confettiPapersSlideTransitionAnimation;
  late Animation<double> _discountTagSlideTransitionAnimation;
  late Animation<double> _neoCoinBlueSlideTransitionAnimation;

  double screenWidth = 0, screenHeight = 0;

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 400,
      ),
      () {
        context.read<DiscoveryAnimationCubit>().forwardNeoCardsAnimation();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: _initAnimation(),
      builder: (context, snapshop) {
        if (snapshop.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return BlocListener<DiscoveryAnimationCubit, DiscoveryAnimationState>(
          listener: (context, state) {
            if (state is ForwardNeoCardsAnimation) {
              switch (_animationController.value) {
                case 0.0:
                  _animationController.animateTo(
                    0.25,
                  );
                  break;
                case 0.25:
                  _animationController.animateTo(
                    0.5,
                  );
                  break;
                case 0.5:
                  _animationController.animateTo(
                    0.75,
                  );
                  break;
                case 0.75:
                  _animationController.animateTo(
                    1.0,
                  );
                  break;
              }
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(
                          _getLuminaCardDxPosition(),
                          _luminaCardFirstSlideTransitionAnimation.value,
                        )
                        ..scale(
                          _getLuminaCardScale(),
                        ),
                      child: Transform.rotate(
                        angle: _getLuminaCardRotation(),
                        child: Assets.pngs.luminaCard.image(
                          width: 141,
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(
                          _getApexCardDxPosition(),
                          _apexCardFirstSlideTransitionAnimation.value,
                        )
                        ..scale(
                          _getApexCardScale(),
                        ),
                      child: Transform.rotate(
                        angle: _getApexCardRotation(),
                        child: Assets.svgs.apexCard.svg(
                          width: 141,
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(
                          _confettiPapersSlideTransitionAnimation.value,
                          screenHeight / 2 - 420,
                        ),
                      child: Assets.pngs.confettiPapers.image(
                        width: 100,
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(
                          _discountTagSlideTransitionAnimation.value,
                          screenHeight / 2 - 380,
                        ),
                      child: Assets.pngs.discountTag.image(
                        width: 100,
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform(
                    transform: Matrix4.identity()
                      ..translate(
                        _giftBoxSlideTransitionAnimation.value,
                        screenHeight / 2 - 120,
                      )
                      ..rotateZ(
                        0.1,
                      ),
                    child: Assets.pngs.giftBox.image(
                      width: 180,
                    ),
                  ),
                ),
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..translate(
                            screenWidth / 2 - 90,
                            _neoCoinBlueSlideTransitionAnimation.value,
                          ),
                        child: Assets.pngs.neoCoinBlue.image(
                          width: 50,
                        ),
                      );
                    }),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(
                          _voucherSlideTransitionAnimation.value,
                          screenHeight / 2 - 20,
                        )
                        ..rotateZ(
                          0.1,
                        ),
                      child: Assets.pngs.voucher.image(width: 150),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _initAnimation() {
    /// Initial position of the cards
    _apexCardInitialPosition = Offset(
      (screenWidth / 2) - 120,
      screenHeight + 200,
    );
    _luminaCardInitialPosition = Offset(
      screenWidth / 2,
      -200,
    );

    /// Animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 4000,
      ),
    );

    ///
    /// First slide animations
    ///

    /// Apex card first slide transition animation
    _apexCardFirstSlideTransitionAnimation = Tween<double>(
      begin: _apexCardInitialPosition.dy,
      end: (screenHeight / 2) - 230,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );

    /// Apex card first slide scale animation
    _apexCardFirstSlideScaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.20,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card first slide transition animation
    _luminaCardFirstSlideTransitionAnimation = Tween<double>(
      begin: _luminaCardInitialPosition.dy,
      end: (screenHeight / 2) - 300,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card first slide scale animation
    _luminaCardFirstSlideScaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.20,
          curve: Curves.ease,
        ),
      ),
    );

    ///
    /// Second slide animations
    ///

    /// Apex card second slide transition animation
    _apexCardSecondSlideTransitionAnimation = Tween<double>(
      begin: _apexCardInitialPosition.dx,
      end: _apexCardInitialPosition.dx + 15,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.25,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    /// Apex card second slide rotation animation
    _apexCardSecondSlideRotationAnimation = Tween<double>(
      begin: -0.4,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.25,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    /// Apex card second slide scale animation
    _apexCardSecondSlideScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.25,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card second slide transition animation
    _luminaCardSecondSlideTransitionAnimation = Tween<double>(
      begin: _luminaCardInitialPosition.dx,
      end: screenWidth + 100,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.25,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card second slide scale animation
    _luminaCardSecondSlideScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.6,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.25,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    ///
    /// Third slide animations
    ///

    /// Apex card third slide transition animation
    _apexCardThirdSlideTransitionAnimation = Tween<double>(
      begin: _apexCardInitialPosition.dx + 15,
      end: -screenWidth / 2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    /// Apex card third slide scale animation
    _apexCardThirdSlideScaleAnimation = Tween<double>(
      begin: 1.5,
      end: 0.6,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.75,
          curve: Curves.easeIn,
        ),
      ),
    );

    /// Apex card third slide rotation animation
    _apexCardThirdSlideRotationAnimation = Tween<double>(
      begin: 0.0,
      end: -0.4,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card third slide transition animation
    _luminaCardThirdSlideTransitionAnimation = Tween<double>(
      begin: screenWidth + 100,
      end: screenWidth / 2 - 105,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card third slide scale animation
    _luminaCardThirdSlideScaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card third slide rotation animation
    _luminaCardThirdSlideRotationAnimation = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    ///
    /// Fourth slide animations
    ///

    /// Apex card fourth slide transition animation
    _apexCardFourthSlideTransitionAnimation = Tween<double>(
      begin: -screenWidth / 2,
      end: _luminaCardInitialPosition.dx - 60,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Apex card fourth slide scale animation
    _apexCardFourthSlideScaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Apex card fourth slide rotation animation
    _apexCardFourthSlideRotationAnimation = Tween<double>(
      begin: -0.4,
      end: 0.2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card fourth slide transition animation
    _luminaCardFourthSlideTransitionAnimation = Tween<double>(
      begin: screenWidth / 2 - 105,
      end: _apexCardInitialPosition.dx - 30,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Lumina card fourth slide rotation animation
    _luminaCardFourthSlideRotationAnimation = Tween<double>(
      begin: 0.0,
      end: -0.2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    ///
    /// Fourth slide animations for other elements
    ///

    /// Voucher slide transition animation
    _voucherSlideTransitionAnimation = Tween<double>(
      begin: screenWidth + 100,
      end: screenWidth / 2 + 30,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Gift box slide transition animation
    _giftBoxSlideTransitionAnimation = Tween<double>(
      begin: -(screenWidth / 2),
      end: screenWidth / 2 - 160,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Neo coin blue slide transition animation
    _neoCoinBlueSlideTransitionAnimation = Tween<double>(
      begin: screenHeight,
      end: screenHeight / 2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Confetti papers slide transition animation
    _confettiPapersSlideTransitionAnimation = Tween<double>(
      begin: -(screenWidth / 2),
      end: screenWidth / 2 - 200,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    /// Discount tag slide transition animation
    _discountTagSlideTransitionAnimation = Tween<double>(
      begin: screenWidth,
      end: screenWidth / 2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  _getApexCardDxPosition() {
    if (_animationController.value <= .25) {
      return _apexCardInitialPosition.dx;
    } else if (_animationController.value <= .5) {
      return _apexCardSecondSlideTransitionAnimation.value;
    } else if (_animationController.value <= .75) {
      return _apexCardThirdSlideTransitionAnimation.value;
    } else if (_animationController.value <= 1.0) {
      return _apexCardFourthSlideTransitionAnimation.value;
    }
  }

  _getApexCardScale() {
    if (_animationController.value <= .25) {
      return _apexCardFirstSlideScaleAnimation.value;
    } else if (_animationController.value <= .5) {
      return _apexCardSecondSlideScaleAnimation.value;
    } else if (_animationController.value <= .75) {
      return _apexCardThirdSlideScaleAnimation.value;
    } else if (_animationController.value <= 1.0) {
      return _apexCardFourthSlideScaleAnimation.value;
    }
  }

  _getLuminaCardDxPosition() {
    if (_animationController.value <= .25) {
      return _luminaCardInitialPosition.dx;
    } else if (_animationController.value <= .5) {
      return _luminaCardSecondSlideTransitionAnimation.value;
    } else if (_animationController.value <= .75) {
      return _luminaCardThirdSlideTransitionAnimation.value;
    } else if (_animationController.value <= 1.0) {
      return _luminaCardFourthSlideTransitionAnimation.value;
    }
  }

  _getLuminaCardScale() {
    if (_animationController.value <= .25) {
      return _luminaCardFirstSlideScaleAnimation.value;
    } else if (_animationController.value <= .5) {
      return _luminaCardSecondSlideScaleAnimation.value;
    } else if (_animationController.value <= .75) {
      return _luminaCardThirdSlideScaleAnimation.value;
    } else if (_animationController.value <= 1.0) {
      return _luminaCardThirdSlideScaleAnimation.value;
    }
  }

  _getApexCardRotation() {
    if (_animationController.value <= .25) {
      return -0.4;
    } else if (_animationController.value <= .5) {
      return _apexCardSecondSlideRotationAnimation.value;
    } else if (_animationController.value <= .75) {
      return _apexCardThirdSlideRotationAnimation.value;
    } else if (_animationController.value <= 1.0) {
      return _apexCardFourthSlideRotationAnimation.value;
    }
  }

  _getLuminaCardRotation() {
    if (_animationController.value <= .25) {
      return 0.4;
    } else if (_animationController.value <= .5) {
      return 0.4;
    } else if (_animationController.value <= .75) {
      return _luminaCardThirdSlideRotationAnimation.value;
    } else if (_animationController.value <= 1.0) {
      return _luminaCardFourthSlideRotationAnimation.value;
    }
  }
}
