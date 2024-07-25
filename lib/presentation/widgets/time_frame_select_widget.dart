import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../theme/app_colors.dart';

class TimeFrameSelectWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color? backgroundColor, foregroundColor;

  const TimeFrameSelectWidget({
    Key? key,
    required this.title,
    this.isSelected = false,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? backgroundColor ?? AppColors.primary[50]
            : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Text(
        title,
        style: baseTextStyle12600.copyWith(
            color: isSelected
                ? foregroundColor ?? AppColors.primary[500]
                : AppColors.neutral[400]),
      ),
    );
  }
}
