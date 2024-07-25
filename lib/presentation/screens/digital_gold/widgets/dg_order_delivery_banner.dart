import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class DGOrderDeliveryBanner extends StatelessWidget {
  const DGOrderDeliveryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.digitalGoldDelivery),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.neutral[500],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: baseTextStyle14400.copyWith(color: Colors.white),
                      children: const [
                        TextSpan(text: 'Get'),
                        TextSpan(
                            text: ' 999 purity ',
                            style: TextStyle(color: AppColors.primaryColor)),
                        TextSpan(
                            text:
                                'physical gold and silver right at your doorstep'),
                      ],
                    ),
                  ),
                  const Gap(8.0),
                  Row(
                    children: [
                      Text(
                        'Order now',
                        style: baseTextStyle12500.copyWith(
                            color: AppColors.alert[500]),
                      ),
                      const Gap(8.0),
                      Icon(Icons.keyboard_arrow_right,
                          color: AppColors.alert[500]),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                const SizedBox(
                  height: 65.0,
                  width: 65.0,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Transform.rotate(
                    angle: 0,
                    child:
                        Assets.pngs.goldCoin.image(height: 50.0, width: 50.0),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Transform.rotate(
                    angle: pi / 4,
                    child:
                        Assets.pngs.silverCoin.image(height: 50.0, width: 50.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
