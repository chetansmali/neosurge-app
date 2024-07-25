import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../data/models/assisted_service/suggested_fund.dart';
import '../../../../theme/app_colors.dart';
import 'suggested_fund_card.dart';

class FundSuggestionList extends HookWidget {
  final List<SuggestedFund> funds;

  const FundSuggestionList({Key? key, required this.funds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: (funds.length / 2).ceil(),
              itemBuilder: (context, index) {
                final int index1 = index * 2;
                final int index2 = index * 2 + 1;

                return _SuggestedFundTwoList(
                  card1:
                      SuggestedFundCard(cardColor: AppColors.assistedServiceFundColors[index1 % 12].withOpacity(0.5), textColor: AppColors.assistedServiceFundColors[index1 % 12], fund: funds[index1]),
                  card2: index2 > funds.length - 1
                      ? null
                      : SuggestedFundCard(
                          cardColor: AppColors.assistedServiceFundColors[index2 % 12].withOpacity(0.5), textColor: AppColors.assistedServiceFundColors[index2 % 12], fund: funds[index2]),
                );
              },
            ),
          ),
          const Gap(5),
          SmoothPageIndicator(
            controller: pageController,
            count: (funds.length / 2).ceil(),
            effect: const ScrollingDotsEffect(
              dotColor: AppColors.darkGrey,
              activeDotColor: AppColors.primaryColor,
              radius: 9,
              dotWidth: 9,
              dotHeight: 9,
            ),
          ),
          // Gap(10),
          // SuggestedFundCard(
          //   cardColor: Color(0xFFE5F5FF),
          //   textColor: Color(0xFF0C97F0),
          // ),
        ],
      ),
    );
  }
}

class _SuggestedFundTwoList extends StatelessWidget {
  final SuggestedFundCard card1;
  final SuggestedFundCard? card2;

  const _SuggestedFundTwoList({Key? key, required this.card1, this.card2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          card1,
          const Gap(20),
          card2 ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
