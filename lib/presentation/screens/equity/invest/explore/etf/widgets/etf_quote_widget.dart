import 'package:flutter/widgets.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../theme/app_colors.dart';

class ETFQuoteWidget extends StatelessWidget {
  const ETFQuoteWidget({
    super.key,
    required this.title,
    required this.value,
    this.isHigh,
  });
  final String title;
  final double? value;
  final bool? isHigh;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: baseTextStyle12400.copyWith(color: AppColors.neutral[400]),
        ),
        Text(
          value != null ? value!.toStringAsFixed(2) : '--',
          style: baseTextStyle14500.copyWith(
              color: isHigh != null
                  ? isHigh!
                      ? AppColors.success[500]
                      : AppColors.error[500]
                  : AppColors.neutral[500]),
        ),
      ],
    );
  }
}
