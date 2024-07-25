import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class DgOrderInProgressCard extends StatelessWidget {
  final DgTransactionModel pendingOrder;

  const DgOrderInProgressCard({Key? key, required this.pendingOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () => Navigator.pushNamed(context, Routes.digitalGoldOrderStatus,
          arguments: DgOrderStatusArgs(
              transaction: pendingOrder,
              transactionStatus: DgTransactionStatus.processing)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 12.0, color: Colors.black.withOpacity(0.08))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${pendingOrder.transactionType == DGTransactionType.buy ? 'Digital' : pendingOrder.transactionType == DGTransactionType.sell ? 'Digital' : 'Physical'} ${pendingOrder.metalType}',
                        style: baseTextStyle14400.copyWith(
                            color: AppColors.neutral[500]),
                      ),
                      const Gap(8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.neutral[100],
                          shape: BoxShape.circle,
                        ),
                        height: 5.0,
                        width: 5.0,
                      ),
                      const Gap(8.0),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: baseTextStyle10400.copyWith(
                                color: AppColors.neutral[400]),
                            children: [
                              TextSpan(
                                  text: '${pendingOrder.totalWeight} ',
                                  style: baseTextStyle12500.copyWith(
                                      color: AppColors.neutral[400])),
                              const TextSpan(text: 'g'),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'en_IN', symbol: '₹')
                            .format(pendingOrder.totalAmount),
                        style: baseTextStyle16500.copyWith(
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      pendingOrder.container,
                      const Gap(5),
                      Expanded(
                        child: Text(
                          DateFormat("dd MMM yy, hh:mm a")
                              .format(pendingOrder.transactionDate.toLocal()),
                          style: baseTextStyle12400.copyWith(
                              color: AppColors.neutral[300]),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Gap(8.0),
            const Icon(
              Icons.chevron_right_rounded,
              size: 30.0,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
