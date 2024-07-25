import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../routes/route_arguments.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../common/utils.dart';

class WatchlistCardPage extends StatelessWidget {
  final String image;
  final String name;
  final String subtitle;
  final double price;
  final double highValue;
  final double percentage;
  final String symbol;

  const WatchlistCardPage({
    super.key,
    required this.symbol,
    required this.image,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.highValue,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.exploreStockDetail,
          arguments: StockDetailsArgs(
            symbolName: symbol,
            close: price,
            change: highValue,
            percentage: percentage,
            industry: '',
            name: name,
            icon: image,
          ),
        );
      },
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
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
                        name.length > 1
                            ? name.substring(0, 1).toUpperCase()
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
              const Gap(10),
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
                            symbol,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: baseTextStyle14400,
                          ),
                        ),
                        Text(
                          Utils.compactCurrency(price),
                          style: baseTextStyle14400,
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            subtitle,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: baseTextStyle10400.copyWith(
                                color: AppColors.textGrey),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              highValue > 0
                                  ? ('+${highValue.toStringAsFixed(2)}')
                                  : (highValue.toStringAsFixed(2)),
                              style: baseTextStyle10400.copyWith(
                                color: highValue > 0
                                    ? AppColors.green
                                    : AppColors.errorRed,
                              ),
                            ),
                            Text(
                              ('(${percentage.toStringAsFixed(2)}%)'),
                              style: baseTextStyle10400.copyWith(
                                  color: percentage > 0
                                      ? AppColors.green
                                      : AppColors.errorRed),
                            ),
                          ],
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
