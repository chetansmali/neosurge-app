import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../theme/app_colors.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.value,
    required this.title,
    this.color,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    super.key,
  });
  final String title;
  final String value;
  final Color? color;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.neutral[400],
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Gap(5),
        Text(
          value,
          style: TextStyle(
            color: color ?? AppColors.neutral[500],
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
