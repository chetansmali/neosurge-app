import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../widgets/amount_widget.dart';

class AlertDetailsPriceCard extends StatelessWidget {
  final String title;
  final double price;
  final Widget image;
  const AlertDetailsPriceCard(
      {super.key,
      required this.title,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: AppColors.textGrey, blurRadius: 0.1)
        ],
        color: const Color(0xFFFEF4EA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            image,
            const Gap(6),
            Expanded(
              child: AmountWidget(
                amount: price,
                isCompact: false,
                style: baseTextStyle14500,
              ),
            ),
            Text(
              title,
              style: baseTextStyle10400,
            )
          ],
        ),
      ),
    );
  }
}
