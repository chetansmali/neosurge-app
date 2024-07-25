import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../theme/app_colors.dart';

class ETFOrderTile extends StatelessWidget {
  const ETFOrderTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isSell,
    required this.status,
    required this.price,
    required this.qty,
  });

  final String image;
  final String title;
  final String subtitle;
  final String isSell;
  final String status;
  final double price;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.08))
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
                        title,
                        style: baseTextStyle14500,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: status == 'COMPLETE'
                              ? AppColors.green.withOpacity(0.1)
                              : status == 'REJECTED'
                                  ? AppColors.errorRed.withOpacity(0.1)
                                  : AppColors.darkYellow.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Center(
                          child: Text(
                            status == 'COMPLETE'
                                ? 'Completed'
                                : status == 'REJECTED'
                                    ? 'Rejected'
                                    : 'Cancelled',
                            style: baseTextStyle10500.copyWith(
                              color: status == 'COMPLETE'
                                  ? AppColors.green
                                  : status == 'REJECTED'
                                      ? AppColors.errorRed
                                      : AppColors.darkYellow,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    subtitle,
                    style: baseTextStyle10400.copyWith(
                      color: AppColors.neutral[400],
                    ),
                  ),
                  const Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${isSell[0] + isSell.substring(1).toLowerCase()} Price',
                        style: baseTextStyle10400.copyWith(
                          color: AppColors.neutral[200],
                        ),
                      ),
                      const Gap(4),
                      Text(Utils.compactCurrency(price).toString(),
                          style: baseTextStyle10500.copyWith(
                            color: AppColors.neutral[500],
                          )),
                      const Gap(10),
                      Text(
                        'Qty ',
                        style: baseTextStyle10400.copyWith(
                          color: AppColors.neutral[200],
                        ),
                      ),
                      const Gap(4),
                      Text(('$qty'),
                          style: baseTextStyle10500.copyWith(
                            color: AppColors.neutral[500],
                          )),
                      const Gap(10),
                      Text(
                        isSell,
                        style: baseTextStyle10400.copyWith(
                            color: isSell == 'SELL'
                                ? AppColors.errorRed
                                : AppColors.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
