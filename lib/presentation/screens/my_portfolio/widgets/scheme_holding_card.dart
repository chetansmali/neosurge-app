import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';

class ShchemeHoldingCard extends StatelessWidget {
  const ShchemeHoldingCard({
    super.key,
    required this.schemeName,
    required this.image,
    this.folioNumber,
    required this.currentValue,
    required this.investedValue,
    required this.returnValue,
    this.returnPercentage,
    this.holdingPercentage,
  });

  final String image;
  final String schemeName;
  final String? folioNumber;
  final double currentValue;
  final double investedValue;
  final double returnValue;
  final double? returnPercentage;
  final double? holdingPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Logo under the container with container color light then logo color.
              if (image.isNotEmpty) ...[
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.contain,
                  ),
                ),
                const Gap(12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schemeName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    if (folioNumber != null) ...[
                      const Gap(4),
                      Text(
                        'Folio Number: $folioNumber',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB0B0B0),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
          const Gap(12),
          const Divider(
            color: AppColors.lightGrey,
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFB0B0B0),
                      ),
                    ),
                    const Gap(2),
                    AmountWidget(
                      amount: currentValue,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invested',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFB0B0B0),
                      ),
                    ),
                    const Gap(2),
                    AmountWidget(
                      amount: investedValue,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Returns',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFB0B0B0),
                      ),
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        AmountWidget(
                          hasSpace: false,
                          preText: returnValue.isNegative ? '- ' : '+ ',
                          amount: returnValue,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: returnValue.isNegative
                                ? AppColors.textRed
                                : AppColors.green,
                          ),
                        ),
                        if (returnPercentage != null) ...[
                          const Gap(4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: returnValue.isNegative
                                  ? AppColors.textRed.withOpacity(
                                      0.1,
                                    )
                                  : AppColors.green.withOpacity(
                                      0.1,
                                    ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              returnValue.isNegative
                                  ? '-'
                                  : '+'
                                      '${returnPercentage!.abs().toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: returnPercentage!.isNegative
                                    ? AppColors.textRed
                                    : AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (holdingPercentage != null)
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Holding %',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB0B0B0),
                        ),
                      ),
                      const Gap(2),
                      Text(
                        '${holdingPercentage!.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
