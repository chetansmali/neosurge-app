import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../common/utils.dart';

class OrderStockTile extends StatelessWidget {
  const OrderStockTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.qty,
    required this.isSell,
    required this.status,
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
      child: Card(
        elevation: 0.5,
        child: Padding(
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
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: baseTextStyle14400,
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 80,
                          decoration: BoxDecoration(
                            color: status == 'COMPLETE'
                                ? AppColors.green.withOpacity(0.1)
                                : status == 'REJECTED'
                                    ? AppColors.errorRed.withOpacity(0.1)
                                    : AppColors.darkYellow.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              status == 'COMPLETE'
                                  ? 'Completed'
                                  : status == 'REJECTED'
                                      ? 'Rejected'
                                      : 'Cancelled',
                              style: TextStyle(
                                fontSize: 12,
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
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitle,
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '$isSell Price',
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        const Gap(2),
                        Text(Utils.compactCurrency(price).toString(),
                            style: baseTextStyle10500),
                        const Gap(10),
                        Text(
                          'Qty ',
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        const Gap(2),
                        Text(('$qty'), style: baseTextStyle10500),
                        const Gap(10),
                        Text(
                          isSell,
                          style: baseTextStyle10500.copyWith(
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
      ),
    );
  }
}
