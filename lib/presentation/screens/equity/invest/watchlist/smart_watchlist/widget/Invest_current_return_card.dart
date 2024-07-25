import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../theme/app_colors.dart';
import '../../../../../../widgets/amount_widget.dart';

class InvestCurrentReturnCard extends StatelessWidget {
  final double investedValue;
  final double currentValue;
  final double returnValue;
  final double returnPercentage;
  const InvestCurrentReturnCard(
      {super.key,
      required this.currentValue,
      required this.investedValue,
      required this.returnPercentage,
      required this.returnValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AmountWidget(
                  amount: investedValue,
                  isCompact: false,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary[500],
                  ),
                ),
                Text(
                  'Invested',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral[200],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AmountWidget(
                  amount: currentValue,
                  isCompact: false,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success[500],
                  ),
                ),
                Text(
                  'Current',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral[200],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  return Row(
                    children: [
                      Text(
                        returnValue > 0
                            ? ('+${returnValue.toStringAsFixed(2)}')
                            : returnValue.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: returnValue > 0
                              ? AppColors.success[500]
                              : AppColors.error[500],
                        ),
                      ),
                      const Gap(4),
                      Text(
                        ('(${returnPercentage.toStringAsFixed(2)}%)'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: returnPercentage > 0
                              ? AppColors.success[500]
                              : AppColors.error[500],
                        ),
                      ),
                    ],
                  );
                }),
                Text(
                  'Returns',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral[200],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
