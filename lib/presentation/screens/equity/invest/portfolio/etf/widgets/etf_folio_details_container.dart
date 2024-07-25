import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../../common/custom_styles.dart';
import '../../../../../../theme/app_colors.dart';

class ETFFolioContainer extends StatelessWidget {
  const ETFFolioContainer({
    super.key,
    this.current,
    this.invested,
    this.returns,
    this.returnsPercentage,
    this.date,
  });
  final double? current, invested, returns, returnsPercentage;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final bool? isProfit = returns != null ? !returns!.isNegative : null;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 8, color: AppColors.primaryColor.withOpacity(0.08))
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Current',
                style:
                    baseTextStyle14400.copyWith(color: AppColors.primaryColor),
              ),
              const Gap(8),
              Text(
                date != null
                    ? '(as of ${DateFormat('dd MMM yyyy').format(date!)})'
                    : '(--)',
                style:
                    baseTextStyle10400.copyWith(color: AppColors.neutral[300]),
              ),
            ],
          ),
          Text(
            current != null ? Utils.compactCurrency(current!) : '₹ --',
            style: baseTextStyle21500.copyWith(color: AppColors.primaryColor),
          ),
          const Gap(8),
          const Divider(),
          const Gap(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invested',
                    style: baseTextStyle14400.copyWith(
                        color: AppColors.neutral[400]),
                  ),
                  const Gap(2),
                  Text(
                    invested != null
                        ? Utils.compactCurrency(invested!)
                        : '₹ --',
                    style: baseTextStyle16500.copyWith(color: Colors.black),
                  ),
                ],
              ),
              const Gap(32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Returns',
                    style: baseTextStyle14400.copyWith(
                        color: AppColors.neutral[400]),
                  ),
                  const Gap(2),
                  Row(
                    children: [
                      Text(
                        returns != null
                            ? '${isProfit! ? '+' : ''} '
                                '${Utils.compactCurrency(returns!)}'
                            : '₹ --',
                        style: baseTextStyle16500.copyWith(
                            color: isProfit != null
                                ? isProfit
                                    ? AppColors.success[500]
                                    : AppColors.error[500]
                                : Colors.black),
                      ),
                      const Gap(4),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isProfit != null
                              ? isProfit
                                  ? AppColors.success[50]
                                  : AppColors.error[50]
                              : AppColors.neutral[50],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            const Gap(2),
                            Text(
                              returnsPercentage != null
                                  ? '${returnsPercentage!.toStringAsFixed(2)}%'
                                  : '--',
                              style: baseTextStyle12400.copyWith(
                                  color: isProfit != null
                                      ? isProfit
                                          ? AppColors.success[500]
                                          : AppColors.error[500]
                                      : Colors.black),
                            ),
                            const Gap(2),
                            if (returnsPercentage != null)
                              Icon(
                                isProfit!
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: isProfit
                                    ? AppColors.success[500]
                                    : AppColors.error[500],
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
