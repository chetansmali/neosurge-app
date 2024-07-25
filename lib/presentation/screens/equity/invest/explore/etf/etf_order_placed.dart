import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../common/common.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../theme/app_colors.dart';

class ETFOrderPlacedScreen extends StatelessWidget {
  const ETFOrderPlacedScreen({
    super.key,
    required this.name,
    this.imageUrl,
    required this.quantity,
    required this.time,
    required this.amount,
    required this.totalAmount,
    required this.isBuying,
    required this.isNSE,
    required this.status,
  });
  final String name;
  final String? imageUrl;
  final int quantity;
  final DateTime time;
  final double amount, totalAmount;
  final bool isBuying, isNSE;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.animations.successCheck.lottie(
                    height: 200,
                    repeat: false,
                    frameRate: FrameRate.max,
                  ),
                  Text(
                    '${isBuying ? 'Buy' : 'Sell'} Order Placed',
                    style: baseTextStyle21500.copyWith(
                        color: AppColors.neutral[500]),
                  ),
                  const Gap(32),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.neutral[50]!),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary[50],
                                image: imageUrl != null
                                    ? DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            imageUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              height: 24.0,
                              width: 24.0,
                              child: imageUrl != null
                                  ? null
                                  : Center(
                                      child: Text(
                                      name.substring(0, 2),
                                      style: baseTextStyle10600.copyWith(
                                          color: AppColors.primary[200]),
                                    )),
                            ),
                            const Gap(8),
                            Expanded(
                                child: Text(
                              name,
                              style: baseTextStyle16500.copyWith(
                                  color: AppColors.neutral[500]),
                            )),
                            const Gap(8),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary[50],
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                  color: AppColors.primary[500]!,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0, right: 13, top: 4, bottom: 4),
                                child: Text(
                                  'NSE',
                                  style: baseTextStyle12700.copyWith(
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(12),
                        Divider(color: AppColors.neutral[50]),
                        const Gap(12),
                        Row(
                          children: [
                            Text(
                              'Qty',
                              style: baseTextStyle14400.copyWith(
                                  color: AppColors.neutral[400]),
                            ),
                            Expanded(
                              child: Text(
                                '$quantity',
                                style: baseTextStyle14500.copyWith(
                                    color: AppColors.primaryColor),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${isBuying ? 'Buy' : 'Sell'} price',
                              style: baseTextStyle14400.copyWith(
                                  color: AppColors.neutral[400]),
                            ),
                            Expanded(
                              child: Text(
                                '₹${totalAmount.toStringAsFixed(3)}',
                                style: baseTextStyle14500.copyWith(
                                    color: AppColors.primaryColor),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Date & Time',
                              style: baseTextStyle14400.copyWith(
                                  color: AppColors.neutral[400]),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat('hh:mma, dd/MM/yy').format(time),
                                style: baseTextStyle14500.copyWith(
                                    color: AppColors.primaryColor),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
            const Gap(24)
          ],
        ),
      ),
    );
  }
}
