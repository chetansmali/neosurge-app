import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entities/enums.dart';
import '../../../animators/fade_animator.dart';
import '../../../cubits/neo_card/discovery/discovery_animation_cubit.dart';

import 'widgets/neo_card_discovery_content.dart';
import 'widgets/neo_cards_animations.dart';
import 'widgets/neo_passes_animation.dart';
import 'widgets/neo_transaction_animation.dart';

class NeoCardDiscovery extends StatefulWidget {
  const NeoCardDiscovery({super.key});

  @override
  State<NeoCardDiscovery> createState() => _NeoCardDiscoveryState();
}

class _NeoCardDiscoveryState extends State<NeoCardDiscovery> {
  var _isAnimationCompleted = false;

  final List<NeoCardDiscoveryContent> content = [
    const NeoCardDiscoveryContent(
      title: Text(
        'Introducing NeoCards',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: Text(
        'The all new Neosurge Virtual Prepaid Cards are here to make your everyday payments easy.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF727579),
          fontSize: 12.0,
        ),
      ),
    ),
    const NeoCardDiscoveryContent(
      title: Text(
        'APEX Card',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: Text(
        'Spend money everywhere you go and receive money at your wallet.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF727579),
          fontSize: 12.0,
        ),
      ),
    ),
    NeoCardDiscoveryContent(
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Lumina ',
              style: GoogleFonts.pinyonScript(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: 'Card',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      description: const Text(
        'Experience luxury through our Lumina way.\nPremium features and exclusive benefits',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF727579),
          fontSize: 12.0,
        ),
      ),
    ),
    const NeoCardDiscoveryContent(
      title: Text(
        'Rewards and Offers',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: Text(
        'Earn NeoCoins every time you use your card and earn rewards and offers!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF727579),
          fontSize: 12.0,
        ),
      ),
    ),
    const NeoCardDiscoveryContent(
      title: Text(
        'Exclusive Passes',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: Text(
        'Get access to Cult memberships, Epicure, Lounge,\nGolf, Accor and more.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF727579),
          fontSize: 12.0,
        ),
      ),
    ),
    const NeoCardDiscoveryContent(
      title: Text(
        'Transactions',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: Text(
        'Track all your spendings from a single dashboard and take control of your finances.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF727579),
          fontSize: 12.0,
        ),
      ),
    ),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 1000),
        () {
          setState(() {
            _isAnimationCompleted = true;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 64.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: FadeAnimator(
                        key: ValueKey<int>(currentIndex),
                        child: content[currentIndex],
                      ),
                    ),
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: !_isAnimationCompleted
                        ? () {}
                        : () {
                            _isAnimationCompleted = false;
                            DiscoveryAnimationCubit discoveryAnimationCubit =
                                context.read<DiscoveryAnimationCubit>();
                            var currentAnimation =
                                discoveryAnimationCubit.animationType;

                            if (currentAnimation ==
                                DiscoveryAnimationType
                                    .forwardNeoCardsAnimation) {
                              discoveryAnimationCubit
                                  .forwardNeoCardsAnimation();
                            } else if (currentAnimation ==
                                DiscoveryAnimationType
                                    .forwardNeoPassesAnimation) {
                              discoveryAnimationCubit
                                  .forwardNeoPassesAnimation();
                            } else if (currentAnimation ==
                                DiscoveryAnimationType
                                    .forwardTransactionAnimation) {
                              discoveryAnimationCubit
                                  .forwardTransactionAnimation();
                            } else if (currentAnimation ==
                                DiscoveryAnimationType
                                    .discoveryAnimationCompleted) {}

                            Future.delayed(
                              const Duration(milliseconds: 1000),
                              () {
                                setState(() {
                                  _isAnimationCompleted = true;
                                });
                              },
                            );

                            if (currentIndex < 5) {
                              setState(() {
                                currentIndex++;
                              });
                            }
                          },
                    child: Text(
                      currentIndex == 5 ? 'Coming Soon' : 'Next',
                    ),
                  ),
                  if (currentIndex == 5) ...[
                    const Gap(4),
                    TextButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text('Go Back to Home'),
                    ),
                  ]
                ],
              ),
            ),
          ),
          BlocBuilder<DiscoveryAnimationCubit, DiscoveryAnimationState>(
            builder: (context, state) {
              return _getAnimation(state);
            },
          ),
        ],
      ),
    );
  }

  Widget _getAnimation(DiscoveryAnimationState state) {
    if (state is ForwardNeoCardsAnimation ||
        state is DiscoveryAnimationInitial) {
      return const CardsAnimation();
    } else if (state is ForwardNeoPassesAnimation) {
      return const NeoPassesAnimation();
    } else if (state is ForwardTransactionAnimation) {
      return const NeoTransactionAnimation();
    }

    return const SizedBox.shrink();
  }
}
