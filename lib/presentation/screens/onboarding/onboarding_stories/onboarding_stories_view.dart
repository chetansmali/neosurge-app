import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../theme/app_colors.dart';
import 'onboarding_animated_text.dart';
import 'onboarding_stories_continue_btns.dart';

class OnboardingStoriesView extends StatefulWidget {
  const OnboardingStoriesView({
    Key? key,
    required this.onboardingData,
  }) : super(key: key);

  final List<Map<String, dynamic>> onboardingData;

  @override
  State<OnboardingStoriesView> createState() => _OnboardingStoriesViewState();
}

class _OnboardingStoriesViewState extends State<OnboardingStoriesView>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _animationController.forward();

    _animationController.addStatusListener((status) async {
      if (_currentPageIndex == 3) {
        return;
      }

      if (status == AnimationStatus.completed) {
        _goToNextPage();
      }
    });
  }

  void _goToNextPage() async {
    if (_currentPageIndex == 3) {
      return;
    }
    _animationController.reset();

    setState(() {
      _currentPageIndex++;
    });

    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  void _goToPreviousPage() async {
    if (_currentPageIndex == 0) {
      return;
    }

    _animationController.reset();

    setState(() {
      _currentPageIndex--;
    });

    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                _goToPreviousPage();
              } else {
                _goToNextPage();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        widget.onboardingData[index]['backgroundColor']),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: OnboardingAnimatedText(
                              title: widget.onboardingData[index]['title'],
                              description: widget.onboardingData[index]
                                  ['description'],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              index == 0
                                  ? Text(
                                      'Swipe left to interact',
                                      style: baseTextStyle12500.copyWith(
                                          color: AppColors.primaryWhite),
                                    )
                                  : const Gap(0),
                              OnboardingStoriesContinueBtn(
                                currentPageIndex: index,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: MediaQuery.of(context).size.height / 2.4,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.85,
                          child: widget.onboardingData[index]['image'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
