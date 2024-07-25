import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../common/common.dart';
import '../../../domain/entities/enums.dart';
import '../../../domain/entities/params/digital_gold/dg_transaction_model.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';

class DigitalGoldOrderStatusScreen extends StatefulWidget {
  final DgTransactionModel transactionModel;
  final DgTransactionStatus transactionStatus;

  const DigitalGoldOrderStatusScreen(
      {Key? key,
      required this.transactionModel,
      required this.transactionStatus})
      : super(key: key);

  @override
  State<DigitalGoldOrderStatusScreen> createState() =>
      _DigitalGoldOrderStatusScreenState();
}

class _DigitalGoldOrderStatusScreenState
    extends State<DigitalGoldOrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Status'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20.0),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: widget.transactionModel.metalType ==
                                    MetalType.gold
                                ? AppColors.alert[100]
                                : AppColors.primary[100],
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: widget.transactionModel.metalType ==
                                  MetalType.gold
                              ? Assets.pngs.goldBrick.image()
                              : Assets.pngs.silverBrick.image(),
                        ),
                        const Gap(12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${widget.transactionModel.transactionType != DGTransactionType.delivery ? 'Digital' : 'Physical'} ${widget.transactionModel.metalType}',
                                    style: baseTextStyle14500.copyWith(
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
                                              text:
                                                  '${widget.transactionModel.totalWeight} ',
                                              style:
                                                  baseTextStyle12500.copyWith(
                                                      color: AppColors
                                                          .neutral[400])),
                                          const TextSpan(text: 'g'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: widget.transactionModel
                                                  .transactionType ==
                                              DGTransactionType.buy
                                          ? AppColors.primary[50]
                                          : widget.transactionModel
                                                      .transactionType ==
                                                  DGTransactionType.sell
                                              ? AppColors.error[50]
                                              : AppColors.alert[100],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 4.0),
                                    child: Text(
                                      widget.transactionModel.transactionType ==
                                              DGTransactionType.buy
                                          ? 'Buy'
                                          : widget.transactionModel
                                                      .transactionType ==
                                                  DGTransactionType.sell
                                              ? 'Sell'
                                              : 'Delivery',
                                      style: widget.transactionModel
                                                  .transactionType ==
                                              DGTransactionType.buy
                                          ? baseTextStyle12500.copyWith(
                                              color: AppColors.primaryColor)
                                          : widget.transactionModel
                                                      .transactionType ==
                                                  DGTransactionType.sell
                                              ? baseTextStyle12500.copyWith(
                                                  color: AppColors.errorRed)
                                              : baseTextStyle12500.copyWith(
                                                  color: AppColors.alert[700]),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(6.0),
                              Row(
                                children: [
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'en_IN', symbol: '₹')
                                        .format(widget
                                            .transactionModel.totalAmount),
                                    style: baseTextStyle14400.copyWith(
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Text(
                                      DateFormat('dd MMM, yyyy').format(widget
                                          .transactionModel.transactionDate),
                                      style: baseTextStyle12400.copyWith(
                                          color: Colors.black))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(20.0),
                    Divider(color: AppColors.neutral[50]),
                    const Gap(20.0),
                    Text(
                      'Order Status',
                      style: baseTextStyle14400.copyWith(color: Colors.black),
                    ),
                    const Gap(4.0),
                    Text(
                      'Order ID: ${widget.transactionModel.transactionId}',
                      style: baseTextStyle12400.copyWith(
                          color: AppColors.neutral[300]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(32),
                    Row(
                      children: [
                        Column(
                          children: [
                            if (widget.transactionStatus ==
                                DgTransactionStatus.failure) ...[
                              const _StepCircle(
                                color: AppColors.errorRed,
                              ),
                              const _StepLine(
                                color: AppColors.errorRed,
                              ),
                              const _StepCircle(
                                color: AppColors.lightGrey,
                              ),
                            ] else if (widget.transactionStatus ==
                                DgTransactionStatus.processing) ...[
                              const _StepCircle(),
                              const _StepLine(),
                              _StepCircle(
                                color: AppColors.alert[500],
                              ),
                            ] else ...[
                              if (widget.transactionModel.transactionType ==
                                  DGTransactionType.sell) ...[
                                _StepCircle(
                                  color:
                                      widget.transactionModel.augmontStatus ==
                                                  'Failed' ||
                                              widget.transactionModel
                                                      .augmontStatus ==
                                                  'Cancelled'
                                          ? AppColors.errorRed
                                          : AppColors.green,
                                ),
                                _StepLine(
                                  color:
                                      widget.transactionModel.augmontStatus ==
                                                  'Failed' ||
                                              widget.transactionModel
                                                      .augmontStatus ==
                                                  'Cancelled'
                                          ? AppColors.errorRed
                                          : AppColors.green,
                                ),
                                const _StepCircle(),
                              ] else ...[
                                const _StepCircle(),
                                const _StepLine(),
                                const _StepCircle(),
                              ]
                            ],
                          ],
                        ),
                        const Gap(24.0),
                        Expanded(
                          child: Column(
                            children: [
                              if (widget.transactionStatus ==
                                  DgTransactionStatus.failure) ...[
                                _StepperContentContainer(
                                  title: widget.transactionModel.augmontStatus
                                      .toString(),
                                  subtitle: '',
                                ),
                                const Gap(20.0),
                                const _StepperContentContainer(
                                  title: 'Order Placed',
                                  subtitle: '',
                                ),
                              ] else if (widget.transactionStatus ==
                                  DgTransactionStatus.processing) ...[
                                _StepperContentContainer(
                                  title: 'Payment Complete',
                                  subtitle: DateFormat('dd MMM yyyy, hh:mm a')
                                      .format(widget
                                          .transactionModel.transactionDate
                                          .toLocal()),
                                ),
                                const Gap(20.0),
                                _StepperContentContainer(
                                  title: widget.transactionModel.augmontStatus,
                                  subtitle:
                                      widget.transactionModel.transactionType ==
                                              DGTransactionType.delivery
                                          ? 'Expected in 10 days'
                                          : 'Expected in 48 hour',
                                ),
                              ] else ...[
                                if (widget.transactionModel.transactionType ==
                                    DGTransactionType.sell) ...[
                                  _StepperContentContainer(
                                    title: 'Order Placed',
                                    subtitle: DateFormat('dd MMM yyyy, hh:mm a')
                                        .format(widget
                                            .transactionModel.updatedDate
                                            .toLocal()),
                                  ),
                                  const Gap(20.0),
                                  _StepperContentContainer(
                                      title:
                                          widget.transactionModel.augmontStatus,
                                      subtitle:
                                          DateFormat('dd MMM yyyy, hh:mm a')
                                              .format(widget
                                                  .transactionModel.updatedDate
                                                  .toLocal())),
                                ] else ...[
                                  _StepperContentContainer(
                                    title:
                                        widget.transactionModel.augmontStatus,
                                    subtitle: DateFormat('dd MMM yyyy, hh:mm a')
                                        .format(widget
                                            .transactionModel.updatedDate
                                            .toLocal()),
                                  ),
                                  const Gap(20.0),
                                  _StepperContentContainer(
                                    title: widget.transactionModel
                                                .transactionType ==
                                            DGTransactionType.buy
                                        ? widget.transactionStatus.toString()
                                        : widget.transactionModel.augmontStatus,
                                    subtitle: DateFormat('dd MMM yyyy, hh:mm a')
                                        .format(widget
                                            .transactionModel.updatedDate
                                            .toLocal()),
                                  ),
                                ]
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(20.0),
                  ],
                ),
              ),
            ),
            const Gap(20.0),
            ElevatedButton(
              onPressed: widget.transactionModel.invoiceUrl != null
                  ? () => Utils.downloadFile(
                        context: context,
                        url: widget.transactionModel.invoiceUrl!,
                        fileName:
                            'invoice_${widget.transactionModel.transactionId}.pdf',
                      )
                  : null,
              child: const Text('Download Invoice'),
            ),
            const Gap(20.0),
          ],
        ));
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.success[200],
      height: 50.0,
      width: 1.0,
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? AppColors.success[200],
      ),
      height: 14.0,
      width: 14.0,
    );
  }
}

class _StepperContentContainer extends StatelessWidget {
  const _StepperContentContainer({
    required this.title,
    required this.subtitle,
  });
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 8.0, color: Colors.black.withOpacity(0.08))
          ]),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              title,
              style: baseTextStyle12400.copyWith(color: AppColors.neutral[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(8.0),
          Text(
            subtitle,
            style: baseTextStyle10400.copyWith(color: AppColors.neutral[200]),
          ),
        ],
      ),
    );
  }
}
