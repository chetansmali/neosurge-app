import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';

class DGOrderProgressBanner extends StatelessWidget {
  const DGOrderProgressBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.goldOrdersScreen,
        arguments: OrderType.gold,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 8.0, color: Colors.black.withOpacity(0.08))
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Assets.pngs.deliveryBike.image(width: 40.0),
            const Gap(16.0),
            Expanded(
              child: Text(
                'View orders in progress',
                style:
                    baseTextStyle14400.copyWith(color: AppColors.neutral[500]),
              ),
            ),
            const Gap(16.0),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
