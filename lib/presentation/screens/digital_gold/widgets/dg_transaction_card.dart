import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../common/extensions.dart';
import '../../../../data/models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../../../data/models/digital_gold/dg_transaction_response_model.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import 'metal_image.dart';

class DgTransactionCard extends StatelessWidget {
  final DgTransactionModel transaction;
  final DgTransactionStatus transactionStatus;

  const DgTransactionCard({
    Key? key,
    required this.transaction,
    required this.transactionStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.digitalGoldOrderStatus,
          arguments: DgOrderStatusArgs(
            transaction: transaction,
            transactionStatus: transactionStatus,
          )),
      child: transaction.transactionType == DGTransactionType.delivery
          ? _DgDeliveryTransactionCard(t: transaction.deliveryTransaction!)
          : _DgBuySellTransactionCard(t: transaction.transaction!),
    );
  }
}

class _TwoRowText extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TwoRowText(this.title, this.subtitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFFC0C0C0),
              fontSize: 10,
            ),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}

class _DgBuySellTransactionCard extends StatelessWidget {
  final DgTransactionResponseModel t;

  const _DgBuySellTransactionCard({Key? key, required this.t})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      '${t.orderType == DGOrderType.buy ? 'Digital' : t.orderType == DGOrderType.sell ? 'Digital' : 'Physical'} ${t.metalType}',
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
                                text: '${t.quantity} ',
                                style: baseTextStyle12500.copyWith(
                                    color: AppColors.neutral[400])),
                            const TextSpan(text: 'g'),
                          ],
                        ),
                      ),
                    ),
                    AmountWidget(
                      amount: t.totalAmount!,
                      style: baseTextStyle16500.copyWith(
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: t.status == DgTransactionStatus.success
                            ? AppColors.success[50]
                            : t.status == DgTransactionStatus.failure
                                ? AppColors.error[50]
                                : AppColors.alert[100],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Text(
                        t.status == DgTransactionStatus.success
                            ? 'Complete'
                            : t.status == DgTransactionStatus.failure
                                ? 'Failed'
                                : 'Processing',
                        style: t.status == DgTransactionStatus.success
                            ? baseTextStyle12500.copyWith(
                                color: AppColors.success[500])
                            : t.status == DgTransactionStatus.failure
                                ? baseTextStyle12500.copyWith(
                                    color: AppColors.errorRed)
                                : baseTextStyle12500.copyWith(
                                    color: AppColors.alert[700]),
                      ),
                    ),
                    const Gap(8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: t.orderType == DGOrderType.buy
                            ? AppColors.primary[50]
                            : t.orderType == DGOrderType.sell
                                ? AppColors.error[50]
                                : AppColors.alert[100],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Text(
                        t.orderType == DGOrderType.buy
                            ? 'Buy'
                            : t.orderType == DGOrderType.sell
                                ? 'Sell'
                                : 'Delivery',
                        style: t.orderType == DGOrderType.buy
                            ? baseTextStyle12500.copyWith(
                                color: AppColors.primaryColor)
                            : t.orderType == DGOrderType.sell
                                ? baseTextStyle12500.copyWith(
                                    color: AppColors.errorRed)
                                : baseTextStyle12500.copyWith(
                                    color: AppColors.alert[700]),
                      ),
                    ),
                    const Gap(5),
                    Expanded(
                      child: Text(
                        DateFormat("dd MMM yy, hh:mm a")
                            .format(t.createdAt.toLocal()),
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
    );
  }
}

Text _getStatus(
    {required DGOrderType orderType,
    required DgTransactionStatus status,
    required String augStatus}) {
  // If the transaction is buy,
  // then show the status of the transaction from backend
  if (orderType == DGOrderType.buy) {
    final String text = status.toString();
    return Text(
      text,
      style: TextStyle(
        color: status == DgTransactionStatus.failure
            ? AppColors.errorRed
            : AppColors.green,
        fontSize: 11,
      ),
    );
  }

  final String text = augStatus.toString();
  return Text(
    text,
    style: TextStyle(
      color: augStatus == 'Failed' || augStatus == 'Cancelled'
          ? AppColors.errorRed
          : AppColors.green,
      fontSize: 11,
    ),
  );
}

class _DgDeliveryTransactionCard extends StatelessWidget {
  final DgDeliveryTransactionResponseModel t;

  const _DgDeliveryTransactionCard({Key? key, required this.t})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            MetalImage(metalType: t.deliveryGoldSilverProduct[0].sku.metalType),
            const Gap(10),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      DateFormat('dd MMM yyyy').format(t.createdAt.toLocal()),
                      style: const TextStyle(
                          fontSize: 10, color: Color(0xFFC0C0C0)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TwoRowText('Qt.',
                        '${t.deliveryGoldSilverProduct[0].sku.productWeight}g'),
                    const Gap(16),
                    _TwoRowText('Price.',
                        '${t.deliveryGoldSilverProduct[0].sku.basePrice}/unit'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      t.totalAmountPaid.toCurrencyWithSymbol(decimalDigits: 2),
                      style: const TextStyle(),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getStatus(
                            orderType: DGOrderType.delivery,
                            status: t.status,
                            augStatus: t.augmontStatus),
                        const Gap(10),
                        const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: AppColors.textGreyGold,
                          size: 12,
                        )
                      ],
                    )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
