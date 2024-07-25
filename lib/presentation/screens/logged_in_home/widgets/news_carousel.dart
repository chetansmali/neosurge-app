import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../cubits/util_cubits/nav_cubit.dart';
import '../../../routes/routes.dart';

class NewsCarousel extends StatefulWidget {
  const NewsCarousel({super.key});

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  Timer? _timer;
  int _index = 0;

  late final List<Widget> carouselItems;

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

    carouselItems = [
      CarouselTile(
        title: const Text(
          'Dive into the world of Indian Stocks!',
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFFFDFDFD),
          ),
        ),
        leading: Stack(
          children: [
            Assets.pngs.bull.image(width: 75, height: 55),
            Assets.animations.twinkleStars.lottie(height: 33, width: 83)
          ],
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF282D32), // Dark grayish blue
            Color(0xFF181B1E), // Very dark grayish blue
          ],
        ),
        design: Assets.pngs.lineDesign.image(),
        onTap: () {
          Navigator.pushNamed(context, Routes.equity);
        },
      ),
      CarouselTile(
        title: const Text(
          maxLines: 2,
          'Introducing Mutual Funds',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFFFDFDFD),
          ),
        ),
        leading: Assets.pngs.money.image(width: 80, height: 80),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF42D885),
            Color(0xFF11BB5D),
          ],
        ),
        design: Assets.pngs.lineDesign.image(),
        onTap: () {
          Navigator.pushNamed(context, Routes.mutualFunds);
        },
      ),
      CarouselTile(
        title: const Text(
          maxLines: 2,
          'Get Loan Against Mutual Funds',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFFFDFDFD),
          ),
        ),
        leading: Assets.pngs.loan.image(width: 64, height: 64),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFECC3C),
            Color(0xFFFECC3C),
          ],
        ),
        design: Assets.pngs.lineDesign2.image(),
        onTap: () {
          context.read<NavCubit>().changeTab(
                context
                    .read<NavCubit>()
                    .state
                    .navTabEntity
                    .copyWith(mainTabIndex: 0),
              );
        },
      ),
    ];

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
    return Column(
      children: [
        SizedBox(
          height: 90,
          child: _buildAnimatedSwitcher(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < carouselItems.length; i++)
                  Container(
                    height: 4,
                    width: 24,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: _index == i
                          ? const Color(0xFF2C3137)
                          : const Color(0xFFEAEAEB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CarouselTile extends StatelessWidget {
  const CarouselTile({
    super.key,
    required this.title,
    required this.gradient,
    required this.leading,
    required this.design,
    required this.onTap,
  });

  final Widget title;
  final Gradient gradient;
  final Widget leading;
  final Widget design;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leading,
                const Gap(16),
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 130,
                          child: title,
                        )),
                    design
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 12),
              child: Assets.pngs.aboveArrow.image(width: 22, height: 22),
            )
          ],
        ),
      ),
    );
  }
}
