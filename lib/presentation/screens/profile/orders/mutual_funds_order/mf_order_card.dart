import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../routes/route_arguments.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/amount_widget.dart';

class MfOrderCard extends HookWidget {
  final MfOrder order;

  const MfOrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.mfOrderStatusScreen,
            arguments: MfOrderStatusArgs(mfOrder: order)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      order.orderType == MFTransactionTypes.switchTransaction ||
                              order.orderType == MFTransactionTypes.stp
                          ? order.outFundName!
                          : order.fundName ?? 'null',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                  const Gap(40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      order.amount == null
                          ? Text(
                              '${order.units!.toStringAsFixed(4)} units',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : AmountWidget(
                              amount: order.amount!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      const Gap(5),
                      Text(DateFormat('dd MMM yyyy').format(order.createdAt),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textGreyGold)),
                    ],
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.orderType}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textGreyGold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        order.status.toString(),
                        style: TextStyle(
                            color: order.status == MFOrderStatus.pending
                                ? AppColors.darkOrange
                                : order.status == MFOrderStatus.failed
                                    ? AppColors.textRed
                                    : AppColors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Gap(10),
                      const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: AppColors.textGreyGold,
                        size: 12,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
