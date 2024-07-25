import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../gen/assets.gen.dart';
import '../../../animators/slide_fade_animator.dart';
import '../../../widgets/neo_text_logo.dart';

class EquityCarousel extends StatefulWidget {
  const EquityCarousel({super.key});

  @override
  State<EquityCarousel> createState() => _EquityCarouselState();
}

class _EquityCarouselState extends State<EquityCarousel> {
  Timer? _timer;
  int _index = 0;

  final List<Widget> carouselItems = [
    const CarouselTile(
      title: Center(
        child: NeoTextLogo(
          neoColor: Colors.white,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(12),
          SlideFadeAnimator(
            child: Text(
              'Investment',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
          Gap(4),
          SlideFadeAnimator(
            child: Text(
              'Made Simple.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      color: Colors.black,
    ),
    CarouselTile(
      title: const Text(
        'Now is the best time to invest in Equity ',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(0xFFFDFDFD),
        ),
      ),
      subtitle: const Text(
        'Start your investment now.',
        style: TextStyle(
          color: Color(0xFFFDFDFD),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      leading: Assets.pngs.carouselMutualFund.image(),
      color: const Color(0xFF1E5945),
    ),
    CarouselTile(
      title: const Text(
        'This Diwali make special with invest in equity',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(0xFFFDFDFD),
        ),
      ),
      subtitle: const Text(
        'Start your investment now.',
        style: TextStyle(
          color: Color(0xFFFDFDFD),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      leading: Assets.pngs.carouselDigitalGold.image(),
      color: const Color(0xFFF2AF1A),
    ),
  ];

  AnimatedSwitcher _buildAnimatedSwitcher() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Container(
        key: UniqueKey(),
        child: carouselItems[_index],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (_index == 2) {
          _index = 0;
        } else {
          _index++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: Stack(
        children: [
          _buildAnimatedSwitcher(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < carouselItems.length; i++)
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _index == i ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselTile extends StatelessWidget {
  const CarouselTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.leading,
  });

  final Widget title;
  final Widget subtitle;
  final Color color;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(
        16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (leading != null) ...[
            leading!,
            const Gap(12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                title,
                const Gap(4),
                subtitle,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
