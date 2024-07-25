import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class OrderStyles {
  const OrderStyles._();

  static TextStyle get finishedStepTitleStyleLight => const TextStyle(color: AppColors.textLightGrey);

  static TextStyle get finishedStepSubtitleStyleLight => const TextStyle(color: AppColors.textLightGrey);

  static TextStyle get unfinishedStepTitleStyleLight => const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGreyGold);

  static TextStyle get unfinishedStepSubtitleStyleLight => const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGreyGold);

  static TextStyle get finishedStepTitleStyleDark => const TextStyle(color: AppColors.textGrey);

  static TextStyle get finishedStepSubtitleStyleDark => const TextStyle(color: AppColors.textGrey);

  static TextStyle get unfinishedStepTitleStyleDark => const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey);

  static TextStyle get unfinishedStepSubtitleStyleDark => const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textGrey);
}
