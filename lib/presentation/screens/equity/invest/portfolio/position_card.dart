import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../theme/app_colors.dart';

GestureDetector positionCard(
    context, icon, title, subtitle, double price, int qty, type) {
  bool isSell = type == 'BUY' ? false : true;
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
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
              const Gap(5),
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
                          style: baseTextStyle14400,
                        ),
                        Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: isSell
                                ? Colors.red.withOpacity(0.1)
                                : Colors.blue.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              isSell ? 'Sell' : 'Buy',
                              style: TextStyle(
                                fontSize: 12,
                                color: isSell
                                    ? AppColors.errorRed
                                    : AppColors.green,
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
                          isSell ? 'Sell Price' : 'Buy Price',
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          price.toString(),
                          style: baseTextStyle10500.copyWith(
                              color: AppColors.mainBlack),
                        ),
                        const Gap(10),
                        Text(
                          'Qty ',
                          style: baseTextStyle10400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          qty.toString(),
                          style: baseTextStyle10500.copyWith(
                              color: AppColors.mainBlack),
                        ),
                        const Gap(10),
                        Text(
                          isSell ? 'Sell' : 'Buy',
                          style: baseTextStyle10500.copyWith(
                              color: isSell
                                  ? AppColors.errorRed
                                  : AppColors.green),
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
    ),
  );
}
