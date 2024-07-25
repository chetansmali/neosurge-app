import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../../common/custom_styles.dart';
import '../../../component/detail_widget.dart';
import '../../../../../theme/app_colors.dart';
import 'buy_sell_bottom_sheet.dart';

class HoldingCard extends StatelessWidget {
  const HoldingCard({
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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (context) {
            return StockDetailBottomSheet(
              image: image,
              symbol: symbol,
              subtitle: subtitle,
              price: price,
              qty: qty,
              dayHighPrice: dayHighPrice,
              dayHighPercent: dayHighPercent,
              invested: invested,
              avgPrice: avgPrice,
              ltp: ltp,
              ltppercentage: ltppercentage,
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                                symbol,
                                style: baseTextStyle14400,
                              ),
                              Text(
                                dayHighPrice > 0
                                    ? '+${dayHighPrice.toStringAsFixed(2)}'
                                    : dayHighPrice.toStringAsFixed(2),
                                style: TextStyle(
                                    color: dayHighPrice > 0
                                        ? AppColors.green
                                        : AppColors.errorRed),
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
                                    color: AppColors.textGrey),
                              ),
                              Text(
                                dayHighPercent > 0
                                    ? '+${dayHighPercent.toStringAsFixed(2)}%'
                                    : '${dayHighPercent.toStringAsFixed(2)}%',
                                style: TextStyle(
                                    color: dayHighPercent > 0
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
                      color: AppColors.mainBlack,
                    ),
                    DetailWidget(
                      value: avgPrice.toStringAsFixed(2),
                      title: 'Avg. Price',
                      color: AppColors.mainBlack,
                    ),
                    DetailWidget(
                      value: qty.toString(),
                      title: 'Qty',
                      color: AppColors.mainBlack,
                    ),
                    DetailWidget(
                      value: ltp.toStringAsFixed(2),
                      title: 'LTP',
                      color: AppColors.mainBlack,
                    ),
                    DetailWidget(
                      value: '(${ltppercentage.toStringAsPrecision(2)}%)',
                      title: '',
                      color: ltppercentage > 0
                          ? AppColors.green
                          : AppColors.errorRed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
