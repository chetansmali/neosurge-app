import 'package:flutter/material.dart';

import '../../../../common/custom_styles.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/gradient_text.dart';
import '../invest/watchlist/smart_watchlist/widget/smart_button.dart';

class SmartWatchlisButton extends StatelessWidget {
  const SmartWatchlisButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 140,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.errorRed,
                AppColors.lightYellow,
              ], // Set your gradient colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
                20.0), // Set your button border radius here
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          left: 1,
          bottom: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SmartButton(
              child: Center(
                child: GradientText(
                  'Smart Watchlist',
                  style: baseTextStyle12500,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.errorRed,
                      AppColors.lightYellow,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
