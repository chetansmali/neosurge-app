import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../data/models/mutual_funds/fund.dart';
import '../../../theme/app_colors.dart';

class FundCard extends StatelessWidget {
  final Fund fund;

  const FundCard({
    Key? key,
    required this.fund,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: fund.imgUrl,
                height: 40,
                width: 40,
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  fund.schemeNameUnique,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // const Gap(5),
              // Row(
              //   children: [
              //     Text(
              //       fund.riskProfile.toString(),
              //       style: const TextStyle(
              //         fontSize: 10,
              //         color: Color(0xFFC0C0C0),
              //       ),
              //     ),
              //     const Gap(5),
              //     RatingBarIndicator(
              //       itemBuilder: (_, index) => const Icon(
              //         Icons.star,
              //         color: AppColors.ratingColor,
              //       ),
              //       itemCount: 5,
              //       rating: fund.vrRating.length.toDouble(),
              //       itemSize: 10,
              //     ),
              //   ],
              // ),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              Text(
                '${fund.performance.threeY == 0.0 ? fund.performance.oneY.toStringAsFixed(2) : fund.performance.threeY.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: AppColors.success[500],
                  fontSize: 18,
                ),
              ),
              const Gap(8),
              Text(
                '${fund.performance.threeY == 0.0 ? '1Y' : '3Y'} returns',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.neutral[300],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
