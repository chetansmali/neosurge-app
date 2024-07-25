import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../gen/assets.gen.dart';

class AssistedServiceFeaturesPageView extends StatefulWidget {
  const AssistedServiceFeaturesPageView({Key? key}) : super(key: key);

  @override
  State<AssistedServiceFeaturesPageView> createState() => _AssistedServiceFeaturesPageViewState();
}

class _AssistedServiceFeaturesPageViewState extends State<AssistedServiceFeaturesPageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.animations.trigger.lottie(height: 300),
                      const Gap(20),
                      Text(
                        'Alerts on Accumulation & Exits',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF2C2C2C)),
                      ),
                      const Gap(10),
                      const Text(
                        'Our Experts suggest perfect time for \n  Invest & exit for Best Returns',
                        style: TextStyle(color: Color(0xFF2C2C2C)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                case 1:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.animations.filterHouse.lottie(height: 300),
                      const Gap(20),
                      Text(
                        'Filtered Fund House',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF2C2C2C)),
                      ),
                      const Gap(10),
                      const Text(
                        'Our Inhouse Experts will suggest Funds.\nBased on your inputs & Market conditions',
                        style: TextStyle(color: Color(0xFF2C2C2C)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                default:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.animations.flipAnimation.lottie(height: 300),
                      const Gap(20),
                      Text(
                        'Auto Rebalancing',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: const Color(0xFF2C2C2C)),
                      ),
                      const Gap(10),
                      const Text(
                        'Active rebalancing to ensure\ncalibration with goals & criteria',
                        style: TextStyle(color: Color(0xFF2C2C2C)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
              }
            },
            itemCount: 3,
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: const ExpandingDotsEffect(
            activeDotColor: Color(0xFFC4C4C4),
            dotColor: Color(0xFFC4C4C4),
            dotWidth: 7,
            dotHeight: 7,
          ),
        ),
      ],
    );
  }
}
