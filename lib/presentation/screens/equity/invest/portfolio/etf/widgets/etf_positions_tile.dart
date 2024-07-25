import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../theme/app_colors.dart';

class ETFPositionsTile extends StatelessWidget {
  const ETFPositionsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.price,
    required this.qty,
  });
  final String icon, title, subtitle, type;
  final double price;
  final int qty;

  @override
  Widget build(BuildContext context) {
    bool isSell = type == 'BUY' ? false : true;

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
                      imageUrl: icon,
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
                          title,
                          style: baseTextStyle14500,
                        ),
                        Text(
                          'Market Delivery',
                          style: baseTextStyle10400.copyWith(
                              color: AppColors.neutral[300]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: isSell
                                ? AppColors.error[50]
                                : AppColors.primary[50],
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Center(
                            child: Text(
                              isSell ? 'Sell' : 'Buy',
                              style: baseTextStyle12500.copyWith(
                                  color: isSell
                                      ? AppColors.errorRed
                                      : AppColors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      subtitle,
                      style: baseTextStyle10400.copyWith(
                          color: AppColors.neutral[400]),
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          isSell ? 'Sell Price' : 'Buy Price',
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.neutral[200],
                          ),
                        ),
                        const Gap(2),
                        Text(
                          price.toString(),
                          style: baseTextStyle10500.copyWith(
                              color: AppColors.neutral[500]),
                        ),
                        const Gap(10),
                        Text(
                          'Qty ',
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.neutral[200],
                          ),
                        ),
                        const Gap(2),
                        Text(
                          qty.toString(),
                          style: baseTextStyle10500.copyWith(
                              color: AppColors.neutral[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
