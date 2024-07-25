import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../component/detail_widget.dart';

class ETFHoldingTile extends StatelessWidget {
  const ETFHoldingTile({
    super.key,
    required this.image,
    required this.symbol,
    required this.subtitle,
    required this.price,
    required this.qty,
    required this.dayHighPrice,
    required this.dayHighPercent,
    required this.invested,
    required this.avgPrice,
    required this.ltp,
    required this.ltppercentage,
  });

  final String image;
  final String symbol;
  final String subtitle;
  final double price;
  final int qty;
  final double dayHighPrice;
  final double dayHighPercent;
  final double invested;
  final double avgPrice;
  final double ltp;
  final double ltppercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.08))
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryLightColor,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      errorWidget: (context, url, error) {
                        return Text(
                          subtitle.length > 1
                              ? subtitle.substring(0, 1).toUpperCase()
                              : '',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          symbol,
                          style: baseTextStyle14500,
                        ),
                        Text(
                          !dayHighPrice.isNegative
                              ? '+${dayHighPrice.toStringAsFixed(2)}'
                              : dayHighPrice.toStringAsFixed(2),
                          style: baseTextStyle14500.copyWith(
                              color: !dayHighPrice.isNegative
                                  ? AppColors.green
                                  : AppColors.errorRed),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitle,
                          style: baseTextStyle10400.copyWith(
                              color: AppColors.neutral[400]),
                        ),
                        Text(
                          !dayHighPercent.isNegative
                              ? '+${dayHighPercent.toStringAsFixed(2)}%'
                              : '${dayHighPercent.toStringAsFixed(2)}%',
                          style: baseTextStyle12500.copyWith(
                              color: !dayHighPercent.isNegative
                                  ? AppColors.green
                                  : AppColors.errorRed),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailWidget(
                value: invested.toStringAsFixed(2),
                title: 'Invested',
                color: AppColors.neutral[500],
              ),
              DetailWidget(
                value: avgPrice.toStringAsFixed(2),
                title: 'Avg. Price',
                color: AppColors.neutral[500],
              ),
              DetailWidget(
                value: qty.toString(),
                title: 'Qty',
                color: AppColors.neutral[500],
              ),
              DetailWidget(
                value: ltp.toStringAsFixed(2),
                title: 'LTP',
                color: AppColors.neutral[500],
              ),
              DetailWidget(
                value: '(${ltppercentage.toStringAsPrecision(2)}%)',
                title: '',
                color: ltppercentage > 0 ? AppColors.green : AppColors.errorRed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
