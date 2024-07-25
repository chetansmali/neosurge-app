import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../theme/app_colors.dart';
import 'circular_count_indicator.dart';

class LoanDetailPaymentHistoryBanner extends StatelessWidget {
  const LoanDetailPaymentHistoryBanner({
    super.key,
    required this.totalPayments,
    required this.onTimePayments,
    required this.delayedPayments,
  });
  final int totalPayments, onTimePayments, delayedPayments;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(
              spreadRadius: 0,
              blurRadius: 8,
              color: const Color(0xff000000).withOpacity(0.08))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Total Payments',
                style:
                    baseTextStyle12400.copyWith(color: AppColors.neutral[400]),
              ),
              Text(
                totalPayments.toString(),
                style:
                    baseTextStyle32500.copyWith(color: AppColors.primary[900]),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  CircularCountIndicator(
                    data: delayedPayments.toString(),
                    bgColor: AppColors.error[50]!,
                    fgColor: AppColors.error[500]!,
                  ),
                  const Gap(8),
                  Text(
                    'Delayed Payments',
                    style: baseTextStyle10400.copyWith(
                        color: AppColors.neutral[200]),
                  ),
                ],
              ),
              Row(
                children: [
                  CircularCountIndicator(
                    data: onTimePayments.toString(),
                    bgColor: AppColors.success[50]!,
                    fgColor: AppColors.success[500]!,
                  ),
                  const Gap(8),
                  Text(
                    'On-time Payments',
                    style: baseTextStyle10400.copyWith(
                        color: AppColors.neutral[200]),
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
