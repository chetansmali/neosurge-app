import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';

class LAMFCoreDataContainer extends StatelessWidget {
  final String title;
  final String? data;
  final double? amount;
  final Color color;

  const LAMFCoreDataContainer({
    super.key,
    required this.title,
    required this.color,
    this.data,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 8,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    baseTextStyle12400.copyWith(color: AppColors.primary[500]!),
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              if (data != null)
                Text(
                  data!,
                  style: baseTextStyle18500.copyWith(color: color),
                )
              else
                AmountWidget(
                  amount: amount!,
                  style: baseTextStyle18500.copyWith(color: color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
